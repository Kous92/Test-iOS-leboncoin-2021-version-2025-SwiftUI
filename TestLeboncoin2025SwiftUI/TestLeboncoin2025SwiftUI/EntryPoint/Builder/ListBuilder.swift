//
//  ListBuilder.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 11/07/2025.
//


final class ListBuilder: ModuleBuilder {
    private var testMode = false
    private var listViewModel: ListViewModel?
    
    init() {
        self.listViewModel = nil
    }
    
    func buildModule(testMode: Bool, coordinator: Coordinator? = nil) {
        self.testMode = testMode
    
        // Injections de dépendances pour le ViewModel, construction des couches présentation, domaine et data
        // 1) Récupération des instances de Repository: couche data
        let dataRepository = getRepository(testMode: testMode)
        let loadRepository = getLoadRepository(testMode: testMode)
        
        // 2) Récupération des instances de cas d'utilisation (use cases): couche domaine
        let itemCategoryFetchUseCase = ItemCategoryFetchUseCase(dataRepository: dataRepository)
        let itemListFetchUseCase = ItemListFetchUseCase(dataRepository: dataRepository)
        let loadSavedSelectedCategoryUseCase = LoadSavedSelectedCategoryUseCase(itemCategorySettingsRepository: loadRepository)
        
        // 3) Application de la couche de présentation: le ViewModel en injectant les couches.
        self.listViewModel = ListViewModel(itemCategoryFetchUseCase: itemCategoryFetchUseCase, itemListFetchUseCase: itemListFetchUseCase, loadSavedSelectedCategoryUseCase: loadSavedSelectedCategoryUseCase)
        
        // Pour le MVVM-C, le ViewModel aura une référence avec le coordinator pour la navigation
        listViewModel?.coordinator = coordinator as? ListCoordinator
    }
    
    // Permet au Coordinator d'injecter la dépendance à la vue pour une mise en place complète des couches de la Clean Architecture
    func getModule() -> ListViewModel {
        guard let listViewModel else {
            fatalError("Une erreur est survenue: ListViewModel non disponible")
        }
        
        return listViewModel
    }
    
    private func getRepository(testMode: Bool) -> Repository {
        return DataRepository(apiService: getDataService(testMode: testMode))
    }
    
    private func getLoadRepository(testMode: Bool) -> ItemCategorySettingsRepository {
        return ItemCategoryUserDefaultsRepository(localSettings: getLocalSettings(testMode: testMode))
    }
    
    private func getDataService(testMode: Bool) -> APIService {
        // return testMode ? NetworkMockAPIService()(forceFetchFailure: false) : NetworkAPIService()
        return NetworkAPIService()
    }
    
    private func getLocalSettings(testMode: Bool) -> LocalSettings {
        return UserDefaultsLocalSettings()
    }
}
