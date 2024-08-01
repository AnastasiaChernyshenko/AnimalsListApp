//
//  CustomModifiers.swift
//  AnimalListView
//
//  Created by Anastasia Railian on 31.07.2024.
//

import SwiftUI

struct ListBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .customBackgroundStyle()
    }
}

extension View {
    func listBackgroundStyle() -> some View {
        modifier(ListBackgroundModifier())
    }
}


struct ListRowBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
}

extension View {
    func listRowBackgroundStyle() -> some View {
        modifier(ListRowBackgroundModifier())
    }
}

struct CustomBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(content.convertUIColor(uiColor: .background))
    }
}

extension View {
    func customBackgroundStyle() -> some View {
        modifier(CustomBackgroundModifier())
    }
}
