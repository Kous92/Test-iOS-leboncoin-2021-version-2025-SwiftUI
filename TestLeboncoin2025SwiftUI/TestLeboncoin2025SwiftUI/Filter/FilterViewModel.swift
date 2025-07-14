//
//  FilterViewModel.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 12/07/2025.
//

import Observation

@Observable class FilterViewModel {
    weak var coordinator: FilterCoordinator?
    var itemCategories: [ItemCategoryViewModel]
    var currentSelectedIndex: Int = 0
    
    init(itemCategories: [ItemCategoryViewModel]) {
        self.itemCategories = itemCategories
    }
    
    func saveSelectedCategory(at index: Int) {
        currentSelectedIndex = index
    }
    
    func loadSetting() {
        // Charger les données, par exemple depuis un UserDefaults ou autre source.
    }
    
    func backToPreviousScreen() {
        // Logique pour revenir à l’écran précédent
        coordinator?.backToHomeView()
    }
}
