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
    
    static func getFakeItemCategories() -> [ItemCategory] {
        return [
            ItemCategory(id: 1, name: "Mutimédia"),
            ItemCategory(id: 2, name: "Mode"),
            ItemCategory(id: 3, name: "Automobile"),
            ItemCategory(id: 4, name: "Immobilier"),
            ItemCategory(id: 5, name: "Alimentaire")
        ]
    }
}
