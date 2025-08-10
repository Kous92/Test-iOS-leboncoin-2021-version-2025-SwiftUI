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
    
        // Dependency injections for ViewModel, building the presentation, domain and data layers
        // 1) Get repository instances: data layer
        let dataRepository = getRepository(testMode: testMode)
        // let loadRepository = getLoadRepository(testMode: testMode)
        
        // 2) Get use case instances: domain layer
        let itemCategoryFetchUseCase = ItemCategoryFetchUseCase(dataRepository: dataRepository)
        // let itemListFetchUseCase = ItemListFetchUseCase(dataRepository: dataRepository)
        // let loadSavedSelectedSourceUseCase = LoadSavedSelectedSourceUseCase(itemCategorySettingsRepository: loadRepository)
        
        
        self.listViewModel = ListViewModel(itemCategoryFetchUseCase: itemCategoryFetchUseCase)
        
        // Les injections des couches se feront ici
        listViewModel?.coordinator = coordinator as? ListCoordinator
    }
    
    func getModule() -> ListViewModel {
        guard let listViewModel else {
            fatalError("Une erreur est survenue: ListViewModel non disponible")
        }
        
        return listViewModel
    }
    
    private func getRepository(testMode: Bool) -> Repository {
        return DataRepository(apiService: getDataService(testMode: testMode))
    }
    
    /*
    private func getLoadRepository(testMode: Bool) -> ItemCategorySettingsRepository {
        return ItemCategoryUserDefaultsRepository(localSettings: getLocalSettings(testMode: testMode))
    }
     */
    
    private func getDataService(testMode: Bool) -> APIService {
        // return testMode ? NetworkMockAPIService()(forceFetchFailure: false) : NetworkAPIService()
        return NetworkAPIService()
    }
    
    /*
    private func getLocalSettings(testMode: Bool) -> LocalSettings {
        return UserDefaultsLocalSettings()
    }
    */
}
