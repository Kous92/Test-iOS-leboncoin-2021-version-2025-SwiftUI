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
        
        // Injections de dépendances pour le ViewModel, construction des couches présentation, domaine et data
        // 1) Récupération des instances de Repository: couche data
        let saveRepository = getSaveRepository(testMode: testMode)
        let loadRepository = getLoadRepository(testMode: testMode)
        
        // 2) Récupération des instances de cas d'utilisation (use cases): couche domaine
        let loadSavedSelectedCategoryUseCase = LoadSavedSelectedCategoryUseCase(itemCategorySettingsRepository: loadRepository)
        let saveSelectedCategorySourceUseCase = SaveSelectedCategorySourceUseCase(itemCategorySettingsRepository: saveRepository)
        
        // 3) Application de la couche de présentation: le ViewModel en injectant les couches.
        self.filterViewModel = FilterViewModel(itemCategories: self.itemCategories, loadSavedSelectedCategoryUseCase: loadSavedSelectedCategoryUseCase, saveSelectedCategoriesUseCase: saveSelectedCategorySourceUseCase)
        
        // Pour le MVVM-C, le ViewModel aura une référence avec le coordinator pour la navigation
        self.filterViewModel?.coordinator = coordinator as? FilterCoordinator
    }
    
    // Permet au Coordinator d'injecter la dépendance à la vue pour une mise en place complète des couches de la Clean Architecture
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
