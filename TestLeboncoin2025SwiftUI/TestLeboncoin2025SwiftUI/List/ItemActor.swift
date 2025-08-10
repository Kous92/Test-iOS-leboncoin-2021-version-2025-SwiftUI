//
//  ItemActor.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 03/08/2025.
//

actor ItemActor {
    private let items: [ItemViewModel]
    
    init(with items: [ItemViewModel]) {
        self.items = items
    }
    
    @concurrent nonisolated func filterItemsWithSearch(query: String, activeCategory: String) async -> [ItemViewModel] {
        var filteredItemsViewModels: [ItemViewModel] = []
        
        if query.isEmpty {
            filteredItemsViewModels = items
        } else {
            filteredItemsViewModels = items.filter { viewModel in
                let title = viewModel.itemTitle.lowercased()
                return title.contains(query.lowercased())
            }
        }
        
        // Il faut conserver le filtre de catégorie s'il est mis en application (excepté le générique)
        if activeCategory != "Toutes catégories" {
            filteredItemsViewModels = filteredItemsViewModels.filter { itemViewModel in
                return itemViewModel.itemCategory == activeCategory
            }
        }
        
        return filteredItemsViewModels
    }
}
