//
//  ItemCategory.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 14/07/2025.
//

// Codable car nécessaire pour la mise en cache et la sauvegarde du paramètre de filtrage
nonisolated struct ItemCategory: Codable, Sendable {
    let id: Int
    let name: String
    
    @MainActor func getDTO() -> ItemCategoryDTO {
        return ItemCategoryDTO(with: self)
    }
}

extension ItemCategory {
    static func getFakeItemCategory() -> ItemCategory {
        return ItemCategory(id: 1, name: "Alimentaire")
    }
}
