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
        ZStack {
            Color.white
                .cornerRadius(8)
                .shadow(color: .gray, radius: 5)
            HStack {
                image
                Spacer(minLength: 20)
                ZStack {
                    VStack(alignment: .leading) {
                        titleText
                        descriptionText
                        Spacer()
                        if animal.isPremium {
                        premiumBlock
                        }
                    }
                    if animal.isComingSoon {
                        comingSoonBlock
                    }
                }
            }.padding()
            
            if animal.isComingSoon {
                Color.black
                    .cornerRadius(8)
                    .opacity(0.5)
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
    
    var comingSoomImage: some View {
        Image("coming_soon_icon")
            .resizable()
            .scaledToFill()
            .frame(width: 80, height: 80)
    }
    
    var lockImage: some View {
        Image("lock_icon")
            .resizable()
            .scaledToFit()
            .foregroundColor(convertUIColor(uiColor: .premium))
            .frame(width: 12, height: 12)
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
            .foregroundColor(convertUIColor(uiColor: .premium))
    }
    
    var premiumBlock: some View {
        HStack {
            lockImage
            subscriptionText
            Spacer()
        }
    }
    
    var comingSoonBlock: some View {
        HStack {
            Spacer()
            comingSoomImage
        }
    }
}

