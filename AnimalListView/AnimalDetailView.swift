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
        ZStack {
            convertUIColor(uiColor: .background)
                .ignoresSafeArea()
            VStack {
                if let animalFacts = animal.content, !animalFacts.isEmpty {
                    VStack {
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
                            Spacer()
                            HStack {
                                previousFactButton
                                Spacer()
                                nextFactButton
                            }
                    }.frame(width: 300, height: 500)
                        .tabViewStyle(PageTabViewStyle())
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(color: .gray, radius: 5)
                } else {
                    noFactsText
                }
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
            isFirstFactPresent() ? selectLastFact() : (selectedIndex -= 1)
        }, label: {
            Image("back")

        }).padding()
    }
    
    var nextFactButton: some View {
        Button(action: {
            isLastFactPresent() ? selectFirstFact() : (selectedIndex += 1)
        }, label: {
                Image("next")
        }).padding()
    }
    
    private func isFirstFactPresent() -> Bool {
        selectedIndex == 0
    }
    
    private func isLastFactPresent() -> Bool {
        selectedIndex == (animal.content?.count ?? 0 - 1)
    }
    
    private func selectLastFact() {
        guard let count = animal.content?.count else { return }
        selectedIndex = count - 1
    }
    
    private func selectFirstFact() {
        selectedIndex = 0
    }
}
