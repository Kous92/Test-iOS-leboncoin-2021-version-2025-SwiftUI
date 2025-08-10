//
//  Repository.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 14/07/2025.
//

protocol Repository: Sendable {
    func fetchItems() async throws -> [ItemDTO]
    func fetchItemCategories() async throws -> [ItemCategoryDTO]
}

protocol ItemCategorySettingsRepository: Sendable {
    func saveSelectedItemCategory(with itemCategory: ItemCategoryDTO) async throws
    func loadSelectedItemCategory() async throws -> ItemCategoryDTO
}
