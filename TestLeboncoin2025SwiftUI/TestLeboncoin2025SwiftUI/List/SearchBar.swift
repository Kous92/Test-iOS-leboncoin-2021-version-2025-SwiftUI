//
//  SearchBar.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 30/06/2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false

    var body: some View {
        HStack {
            TextField("Rechercher...", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .onTapGesture {
                    isEditing = true
                }

            if isEditing {
                Button("Annuler") {
                    text = ""
                    isEditing = false
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .padding(.trailing)
            }
        }
        .padding(.top)
    }
}
