//
//  AnimalListView.swift
//  AnimalListView
//
//  Created by Anastasia Railian on 31.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct AnimalListView: View {
    let store: StoreOf<AnimalListReducer>
    
    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                NavigationView {
                    List {
                        ForEach(viewStore.animals) { animal in
                            ZStack {
                                if !animal.isComingSoon {
                                    NavigationLink(state: AnimalListReducer.Path.State.animalFacts(.init(animal: animal, hasAdd: animal.status == .paid))) {
                                        EmptyView()
                                    }.opacity(0)
                                } else {   
                                    NavigationLink(state: AnimalListReducer.Path.State.comingSoon(.init())) {
                                        EmptyView()
                                    } .opacity(0)
                                }
                                AnimalCell(animal: animal)
                            }
                        }.listRowBackgroundStyle()
                    }.listBackgroundStyle()
                        .refreshable {
                            viewStore.send(.fetchAnimals)
                        }
                        .navigationTitle("Animals")
                        .onAppear {
                            viewStore.send(.fetchAnimals)
                        }
                }
            }
       
        } destination: { store in
            switch store {
            case .animalFacts:
                CaseLet(
                    /AnimalListReducer.Path.State.animalFacts,
                     action: AnimalListReducer.Path.Action.animalFacts,
                     then: AnimalFactsView.init(store:)
                )
            case .comingSoon:
                CaseLet(
                    /AnimalListReducer.Path.State.comingSoon,
                     action: AnimalListReducer.Path.Action.comingSoon,
                     then: ComingSoonView.init(store:)
                )
            }
        }.customBackgroundStyle()
    }
}
