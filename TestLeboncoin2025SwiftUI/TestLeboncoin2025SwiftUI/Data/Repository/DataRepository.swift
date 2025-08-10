//
//  DataRepository.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/08/2025.
//

final class DataRepository: Repository {
    private let apiService: APIService?
    
    init(apiService: APIService?) {
        self.apiService = apiService
    }
    
    func fetchItems() async throws -> [ItemDTO] {
        do {
            let items = try await apiService?.fetchItems() ?? []
            return await handleItemsResult(with: items)
        } catch APIError.errorMessage(let message) {
            throw APIError.errorMessage(message)
        }
    }
    
    func fetchItemCategories() async throws -> [ItemCategoryDTO] {
        do {
            let itemCategories = try await apiService?.fetchItemCategories() ?? []
            return await handleItemCategoriesResult(with: itemCategories)
        } catch APIError.errorMessage(let message) {
            throw APIError.errorMessage(message)
        }
    }
    
    private func handleItemsResult(with result: [Item]) async -> [ItemDTO] {
        return itemsToDTO(with: result)
    }
    
    private func handleItemCategoriesResult(with result: [ItemCategory]) async -> [ItemCategoryDTO] {
        return itemCategoriesToDTO(with: result)
    }
    
    /// Conversion des données des items en Data Transfer Object (objet de transfert de données) pour la couche Domaine
    private func itemsToDTO(with items: [Item]) -> [ItemDTO] {
        var dtoList = [ItemDTO]()
        items.forEach { dtoList.append(ItemDTO(with: $0)) }
        
        return dtoList
    }
    
    /// Conversion des données des catégories en Data Transfer Object (objet de transfert de données) pour la couche Domaine
    private func itemCategoriesToDTO(with itemCategories: [ItemCategory]) -> [ItemCategoryDTO] {
        var dtoList = [ItemCategoryDTO]()
        itemCategories.forEach { dtoList.append(ItemCategoryDTO(with: $0)) }
        
        return dtoList
    }
}
