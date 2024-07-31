//
//  AnimalCell.swift
//  AnimalListView
//
//  Created by Anastasia Railian on 31.07.2024.
//

import SwiftUI

struct AnimalCell: View {
    let animal: Animal
    
    var body: some View {
        HStack {
            image
            VStack(alignment: .leading) {
                titleText
                descriptionText
                Spacer()
                subscriptionText
            }
        }
    }
}

private extension AnimalCell {
    var image: some View {
        AsyncImage(url: URL(string: animal.image)) { image in
            image.resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .cornerRadius(7)
        } placeholder: {
            ProgressView()
                .frame(width: 120, height: 120)
        }
    }
    
    var titleText: some View {
        Text(animal.title)
            .font(.headline)
    }
    
    var descriptionText: some View {
        Text(animal.description)
            .font(.subheadline)
    }
    
    var subscriptionText: some View {
        Text(animal.status?.title ?? "Coming Soon")
            .font(.subheadline)
            .foregroundColor(.accentColor)
    }
}

