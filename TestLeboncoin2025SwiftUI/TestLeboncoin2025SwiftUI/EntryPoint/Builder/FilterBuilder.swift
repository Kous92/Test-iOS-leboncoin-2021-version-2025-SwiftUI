//
//  FilterBuilder.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 13/07/2025.
//

final class FilterBuilder: ModuleBuilder {
    private var testMode = false
    private let filterViewModel: FilterViewModel
    
    init(with itemCategories: [ItemCategoryViewModel]) {
        self.filterViewModel = FilterViewModel(itemCategories: itemCategories)
    }
    
    func buildModule(testMode: Bool, coordinator: Coordinator? = nil) {
        self.testMode = testMode
    
        // Les injections des couches se feront ici
        filterViewModel.coordinator = coordinator as? FilterCoordinator
    }
    
    func getModule() -> FilterViewModel {
        return filterViewModel
    }
}
