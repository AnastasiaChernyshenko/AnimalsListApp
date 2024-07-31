//
//  AnimalListViewApp.swift
//  AnimalListView
//
//  Created by Anastasia Railian on 31.07.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct AnimalListViewApp: App {
    private static let store = Store(initialState: AnimalListReducer.State(), reducer: {
        AnimalListReducer()
    })

    var body: some Scene {
        WindowGroup {
            AnimalListView(store: AnimalListViewApp.store)
        }
    }
}
