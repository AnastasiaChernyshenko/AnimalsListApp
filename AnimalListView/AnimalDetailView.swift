//
//  AnimalDetailView.swift
//  AnimalListView
//
//  Created by Anastasia Railian on 31.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct AnimalDetailView: View {
    
    let animal: Animal
    @State private var selectedIndex = 0

    var body: some View {
        VStack {
            if let animalFacts = animal.content, !animalFacts.isEmpty {
                ZStack {
                    TabView(selection: $selectedIndex) {
                        ForEach(0..<animalFacts.count) { index in
                            VStack {
                                AsyncImage(url: URL(string: animalFacts[index].image)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(height: 200)
                                Text(animalFacts[index].fact)
                                    .padding()
                                Spacer()
                            }.tag(index)
                        }}
                    VStack {
                        Spacer()
                        HStack {
                            if selectedIndex > 0 {
                                previousFactButton
                            }
                            Spacer()
                            if selectedIndex < animalFacts.count - 1 {
                                nextFactButton
                            }
                        }
                    }
                }.frame(width: 300, height: 500)
                    .tabViewStyle(PageTabViewStyle())
                    .background(.gray)
                    .cornerRadius(15)
            } else {
                noFactsText
            }
        }
        .navigationTitle(animal.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension AnimalDetailView {

    var noFactsText: some View {
       Text("No facts about this animal")
    }
    
    var previousFactButton: some View {
        Button(action: {
            selectedIndex -= 1
        }, label: {
            Image(systemName: "arrow.left")

        })
        .actionButtonStyle()
    }
    
    var nextFactButton: some View {
        Button(action: {
            selectedIndex += 1
        }, label: {
                Image(systemName: "arrow.right")
        })
        .actionButtonStyle()
    }
}
