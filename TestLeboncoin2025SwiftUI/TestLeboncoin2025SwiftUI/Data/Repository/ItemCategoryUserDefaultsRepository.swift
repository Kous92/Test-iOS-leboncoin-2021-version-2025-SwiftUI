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
    
    /// Converts Data Transfer Object to encodable SavedSource for Data Layer
    private func dtoToItemCategory(with dto: ItemCategoryDTO) -> ItemCategory {
        return dto.getEncodableItemCategory()
    }
    
    /// Converts SavedSource data objects to Source Data Transfer Object for Domain Layer
    private func itemCategoryToDTO(with itemCategory: ItemCategory) -> ItemCategoryDTO {
        return itemCategory.getDTO()
    }
}
