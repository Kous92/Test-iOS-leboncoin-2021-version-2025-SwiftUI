//
//  MockLocalSettings.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 17/08/2025.
//

final class MockLocalSettings: LocalSettings {
    private let forceFailure: Bool
    
    init(forceFailure: Bool = false) {
        self.forceFailure = false
    }
    
    func saveSelectedItemCategory(with itemCategory: ItemCategory) async throws {
        print("[MockLocalSettings] Sauvegarde de la catégorie: \(itemCategory.name), id: \(itemCategory.id)")
        
        guard forceFailure == false else {
            throw APIError.errorMessage("Une erreur est survenue lors de la sauvgarde de la catégorie.")
        }
    }
    
    func loadSelectedItemCategory() async throws -> ItemCategory {
        print("[MockLocalSettings] Chargement de la catégorie sauvegardée.")
        
        guard forceFailure == false else {
            throw APIError.errorMessage("nothingSaved")
        }
        
        return ItemCategory.getFakeItemCategory()
    }
}
