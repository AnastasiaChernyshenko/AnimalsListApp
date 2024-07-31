//
//  ComingSoonDomain.swift
//  AnimalListView
//
//  Created by Anastasia Railian on 31.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct ComingSoonDomain: Reducer {
    @Dependency(\.dismiss) var dismiss
    
    struct State: Equatable {
        var wasTapped = false
    }
    
    enum Action: Equatable {
        case buttonTapped
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .buttonTapped:
                state.wasTapped = true
                return .run { _ in await self.dismiss() }
            }
        }
    }
}

struct ComingSoonView: View {
    var store: StoreOf<ComingSoonDomain>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("This animal will come soon")
                Button("Ok") {
                    viewStore.send(.buttonTapped)
                }
            }
        }
    }
}
