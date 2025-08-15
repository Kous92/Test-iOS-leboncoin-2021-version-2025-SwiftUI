//
//  FilterBuilder.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 13/07/2025.
//

final class FilterBuilder: ModuleBuilder {
    private var testMode = false
    private var filterViewModel: FilterViewModel?
    private let itemCategories: [ItemCategoryViewModel]
    
    init(with itemCategories: [ItemCategoryViewModel]) {
        self.itemCategories = itemCategories
        self.filterViewModel = nil
    }
    
    func buildModule(testMode: Bool, coordinator: Coordinator? = nil) {
        self.testMode = testMode
        
        // Dependency injections for ViewModel, building the presentation, domain and data layers
        // 1) Get repository instances: data layer
        let saveRepository = getSaveRepository(testMode: testMode)
        let loadRepository = getLoadRepository(testMode: testMode)
        
        // 2) Get use case instances: domain layer
        let loadSavedSelectedCategoryUseCase = LoadSavedSelectedCategoryUseCase(itemCategorySettingsRepository: loadRepository)
        let saveSelectedCategorySourceUseCase = SaveSelectedCategorySourceUseCase(itemCategorySettingsRepository: saveRepository)
        
        self.filterViewModel = FilterViewModel(itemCategories: self.itemCategories, loadSavedSelectedCategoryUseCase: loadSavedSelectedCategoryUseCase, saveSelectedCategoriesUseCase: saveSelectedCategorySourceUseCase)
        
        // Les injections des couches se feront ici
        self.filterViewModel?.coordinator = coordinator as? FilterCoordinator
    }
    
    func getModule() -> FilterViewModel {
        guard let filterViewModel else {
            fatalError("Une erreur est survenue: FilterViewModel non disponible")
        }
        
        return filterViewModel
    }
    
    private func getLoadRepository(testMode: Bool) -> ItemCategorySettingsRepository {
        return ItemCategoryUserDefaultsRepository(localSettings: getLocalSettings(testMode: testMode))
    }
    
    private func getSaveRepository(testMode: Bool) -> ItemCategorySettingsRepository {
        return ItemCategoryUserDefaultsRepository(localSettings: getLocalSettings(testMode: testMode))
    }
    
    private func getLocalSettings(testMode: Bool) -> LocalSettings {
        return UserDefaultsLocalSettings()
    }
}
