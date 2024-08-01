//
//  Animal.swift
//  AnimalListView
//
//  Created by Anastasia Railian on 31.07.2024.
//

import Foundation

struct Animal: Identifiable, Decodable, Equatable {
    let id: UUID = UUID()
    let title: String
    let image: String
    let description: String
    let status: AnimalPaidStatus?
    var content: [AnimalContent]?
    
    var isPremium: Bool {
        status == .paid
    }
    
    var isComingSoon: Bool {
        status == nil
    }
}

enum AnimalPaidStatus: String, Codable, Equatable {
    case paid
    case free
    
    var title: String {
        switch self {
        case .paid:
            "Premium"
        case .free:
            ""
        }
    }
}

struct AnimalContent: Identifiable, Codable, Equatable {
    let id: UUID = UUID()
    let fact: String
    let image: String
}
