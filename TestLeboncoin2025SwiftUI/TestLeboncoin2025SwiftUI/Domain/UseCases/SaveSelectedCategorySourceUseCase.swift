//
//  SaveSelectedSourceUseCase.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 13/08/2025.
//

final class SaveSelectedCategorySourceUseCase: SaveSelectedCategoryUseCaseProtocol {
    private let itemCategorySettingsRepository: ItemCategorySettingsRepository
    
    nonisolated init(itemCategorySettingsRepository: ItemCategorySettingsRepository) {
        self.itemCategorySettingsRepository = itemCategorySettingsRepository
    }
    
    @concurrent nonisolated func execute(with savedCategory: ItemCategoryDTO) async throws {
        try await itemCategorySettingsRepository.saveSelectedItemCategory(with: savedCategory)
    }
}
