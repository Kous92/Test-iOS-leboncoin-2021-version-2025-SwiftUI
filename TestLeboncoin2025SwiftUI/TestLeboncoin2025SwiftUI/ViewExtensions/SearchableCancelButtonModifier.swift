//
//  SearchableCancelButtonModifier.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 18/08/2025.
//

import SwiftUI

struct SearchCancelButtonModifier: ViewModifier {
    let text: String
    let color: UIColor
    let font: UIFont
    
    init(text: String, color: UIColor = .label, font: UIFont = .systemFont(ofSize: 16, weight: .regular)) {
        self.text = text
        self.color = color
        self.font = font
        
        // Configuration UIAppearance pour toutes les barres de recherche
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: font
        ]
        
        let appearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        appearance.title = text
        appearance.setTitleTextAttributes(attributes, for: .normal)
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    /// Applique une personnalisation au bouton "Cancel" de la recherche
    func searchCancelButton(text: String = "Annuler", color: UIColor = .label, font: UIFont = .systemFont(ofSize: 16, weight: .regular)) -> some View {
        self.modifier(SearchCancelButtonModifier(text: text, color: color, font: font))
    }
}
