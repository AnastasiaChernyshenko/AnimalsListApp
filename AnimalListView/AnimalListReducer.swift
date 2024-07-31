//
//  AnimalListReducer.swift
//  AnimalListView
//
//  Created by Anastasia Railian on 31.07.2024.
//

import ComposableArchitecture
import SwiftUI

class AnimalListReducer: Reducer {
    struct Path: Reducer {
        enum State {
            case animalFacts(AnimalFacts.State)
            case comingSoon(ComingSoonDomain.State)
        }
        enum Action {
            case animalFacts(AnimalFacts.Action)
            case comingSoon(ComingSoonDomain.Action)
        }
        var body: some ReducerOf<Self> {
            Scope(state: /State.animalFacts, action: /Action.animalFacts) {
                AnimalFacts()
            }
            
            Scope(state: /State.comingSoon, action: /Action.comingSoon) {
                ComingSoonDomain()
            }
        }
    }
    
    struct State: Equatable {
        static func == (lhs: AnimalListReducer.State, rhs: AnimalListReducer.State) -> Bool {
            lhs.animals == rhs.animals
        }
        
        var animals: [Animal] = []
        var isLoading: Bool = false
        var path = StackState<Path.State>()
        
    }
    
    enum Action {
        case fetchAnimals
        case fetchAnimalsResponse(Result<[Animal], AnimalError>)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some ReducerOf<AnimalListReducer> {
        Reduce { state, action in
            switch action {
            case .fetchAnimals:
                state.isLoading = true
                return .run { send in
                    do {
                        let animals = try await self.fetchAnimals()
                        await send(.fetchAnimalsResponse(.success(animals)))
                    } catch {
                        await send(.fetchAnimalsResponse(.failure(.networkError(error))))
                    }
                }
            case let .fetchAnimalsResponse(.success(animals)):
                state.isLoading = false
                state.animals = animals
                return .none
                
            case let .fetchAnimalsResponse(.failure(error)):
                state.isLoading = false
                // Handle error (e.g., show an alert)
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
    
    private func fetchAnimals() async throws -> [Animal] {
        guard let url = URL(string: "https://raw.githubusercontent.com/AppSci/promova-test-task-iOS/main/animals.json") else { return []}
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let animals = try JSONDecoder().decode([Animal].self, from: data)
            return animals
        } catch {
            throw AnimalError.decodingError(error)
        }
    }
}


// MARK: - Error Handling
enum AnimalError: Error, Equatable {
    case networkError(Error)
    case decodingError(Error)
    
    static func == (lhs: AnimalError, rhs: AnimalError) -> Bool {
        switch (lhs, rhs) {
        case (.networkError(let lhsError), .networkError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.decodingError(let lhsError), .decodingError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

