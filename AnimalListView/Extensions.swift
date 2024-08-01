//
//  Extensions.swift
//  AnimalListView
//
//  Created by Anastasia Railian on 01.08.2024.
//

import SwiftUI

extension View {
    func convertUIColor(uiColor: UIColor) -> Color {
        let components = uiColor.cgColor.components
        let red = components?[0] ?? 0.0
        let green = components?[1] ?? 0.0
        let blue = components?[2] ?? 0.0
        return Color(red: Double(red), green: Double(green), blue: Double(blue))
    }
}

