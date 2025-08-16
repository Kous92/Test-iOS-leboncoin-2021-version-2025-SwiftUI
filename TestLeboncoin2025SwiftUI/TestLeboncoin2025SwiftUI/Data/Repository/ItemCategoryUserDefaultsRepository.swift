//
//  ItemCategoryUserDefaultsRepository.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 13/08/2025.
//

final class ItemCategoryUserDefaultsRepository: ItemCategorySettingsRepository {
    private let localSettings: LocalSettings?
    
    init(localSettings: LocalSettings?) {
        self.localSettings = localSettings
    }
    
    func saveSelectedItemCategory(with itemCategory: ItemCategoryDTO) async throws {
        do {
            try await localSettings?.saveSelectedItemCategory(with: dtoToItemCategory(with: itemCategory))
        } catch APIError.errorMessage(let message) {
            throw APIError.errorMessage(message)
        }
    }
    
    func loadSelectedItemCategory() async throws -> ItemCategoryDTO {
        guard let itemCategory = try await localSettings?.loadSelectedItemCategory() else {
            throw APIError.errorMessage("Une erreur est survenue lors du chargement de la catégorie.")
        }
        
        return itemCategoryToDTO(with: itemCategory)
    }
    
    /// Convertit l'objet de transfert de données (DTO: Data Transfer Object) en un SavedSource encodable pour la couche Data
    private func dtoToItemCategory(with dto: ItemCategoryDTO) -> ItemCategory {
        return dto.getEncodableItemCategory()
    }
    
    /// Convertit un objet SavedSource en objet de transfert de données (DTO: Data Transfer Object) pour la couche domaine
    private func itemCategoryToDTO(with itemCategory: ItemCategory) -> ItemCategoryDTO {
        return itemCategory.getDTO()
    }
}
