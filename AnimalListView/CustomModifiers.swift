//
//  CustomModifiers.swift
//  AnimalListView
//
//  Created by Anastasia Railian on 31.07.2024.
//

import SwiftUI

struct ActionButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .accentColor(.blue)
            .frame(width: 40, height: 40)
            .background(.white,
                  in: RoundedRectangle(cornerRadius: 12))
            .padding()
    }
}

extension View {
    func actionButtonStyle() -> some View {
        modifier(ActionButtonModifier())
    }
}
