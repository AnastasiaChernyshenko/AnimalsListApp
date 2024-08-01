//
//  AddView.swift
//  AnimalListView
//
//  Created by Anastasia Railian on 01.08.2024.
//

import SwiftUI

struct AddView: View {
    var body: some View {
        ZStack {
           convertUIColor(uiColor: .background)
                .ignoresSafeArea()
            VStack {
                Text("Тут могла бы быть ваша реклама")
                    .padding()
                ProgressView()
            }
        
        }
    }
}

#Preview {
    AddView()
}
