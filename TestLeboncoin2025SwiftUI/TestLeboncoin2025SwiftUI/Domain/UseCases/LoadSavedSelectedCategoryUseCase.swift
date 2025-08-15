//
//  LoadSavedSelectedCategoryUseCase.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 13/08/2025.
//

final class LoadSavedSelectedCategoryUseCase: LoadSavedSelectedCategoryUseCaseProtocol {
    private let itemCategorySettingsRepository: ItemCategorySettingsRepository
    
    nonisolated init(itemCategorySettingsRepository: ItemCategorySettingsRepository) {
        self.itemCategorySettingsRepository = itemCategorySettingsRepository
    }
    
    @concurrent nonisolated func execute() async throws -> ItemCategoryDTO {
        return try await itemCategorySettingsRepository.loadSelectedItemCategory()
    }
}
