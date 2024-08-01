//
//  AnimalFacts.swift
//  AnimalListView
//
//  Created by Anastasia Railian on 31.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct AnimalFacts: Reducer {
    struct State: Equatable {
        var animal: Animal
        var hasAdd: Bool
    }
    
    enum Action: Equatable {
        case hideAdd
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .hideAdd:
                state.hasAdd = false
                return .none
            }
        }
    }
}

struct AnimalFactsView: View {
    var store: StoreOf<AnimalFacts>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            if viewStore.hasAdd {
                AddView().onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        viewStore.send(.hideAdd)
                    }
                }
            } else {
                AnimalDetailView(animal: viewStore.animal)
            }
        }
    }
}
