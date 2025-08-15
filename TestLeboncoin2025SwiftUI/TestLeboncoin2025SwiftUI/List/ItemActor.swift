//
//  ItemActor.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 03/08/2025.
//

import Foundation

actor ItemActor {
    private var items: [ItemViewModel]
    private let categories: [ItemCategoryViewModel]
    
    init(with items: [ItemViewModel], and categories: [ItemCategoryViewModel]) {
        self.items = items
        self.categories = categories
    }
    
    @concurrent nonisolated func filterItemsWithSearch(query: String, activeCategory: String) async -> [ItemViewModel] {
        print("[ItemActor] filterItemsWithSearch -> Thread: \(Thread.currentThread)")
        var filteredItemsViewModels: [ItemViewModel] = []
        
        if query.isEmpty {
            filteredItemsViewModels = await items
        } else {
            filteredItemsViewModels = await items.filter { viewModel in
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
    
    @concurrent nonisolated func filterItemsByCategory(with itemCategoryName: String, activeSearch: String) async -> [ItemViewModel] {
        print("[ItemActor] filterItemsWithSearch -> Thread: \(Thread.currentThread)")
        var filteredItemsViewModels: [ItemViewModel] = []
        
        if itemCategoryName == "Toutes catégories" {
            filteredItemsViewModels = await items
        } else {
            filteredItemsViewModels = await items.filter { viewModel in
                // Attention à un bug: Si un filtrage par recherche est déjà actif, il faut le prendre en compte.
                let matchingCategory = viewModel.itemCategory == itemCategoryName
                
                // print(">>> Filtrage de catégories avec recherche: \(!searchQuery.isEmpty)")
                if !activeSearch.isEmpty {
                    let title = viewModel.itemTitle.lowercased()
                    return title.contains(activeSearch.lowercased()) && matchingCategory
                }
                
                return matchingCategory
            }
        }
        
        return filteredItemsViewModels
    }
    
    @concurrent nonisolated func parseViewModels() async -> [ItemViewModel] {
        print("[ItemActor] parseViewModels -> Thread: \(Thread.currentThread)")
        let parsedViewModels = await items.map { item in
            let categoryId = self.categories.firstIndex { category in
                guard let id = Int(item.itemCategory) else {
                    return false
                }
                
                return id == category.id
            }
            
            var category = "Inconnu"
            
            if let categoryId {
                category = self.categories[categoryId].name
            }
            
            return ItemViewModel(smallImageURL: item.smallImage, thumbImageURL: item.thumbImage, itemTitle: item.itemTitle, itemCategory: category, itemPrice: item.itemPrice, isUrgent: item.isUrgent, itemDescription: item.itemDescription, itemAddedDate: item.itemAddedDate, siret: item.siret)
        }
        
        return await sortItems(with: parsedViewModels)
    }
    
    private func sortItems(with parsedItems: [ItemViewModel]) ->  [ItemViewModel]{
        print("[ItemActor] sortItems -> Thread: \(Thread.currentThread)")
        // ✅ Tri : urgents en premier, puis triés par date décroissante
        items = parsedItems.sorted(by: { lhs, rhs in
            if lhs.isUrgent != rhs.isUrgent {
                return lhs.isUrgent && !rhs.isUrgent // urgents d'abord
            }
            
            // Comparer les dates en ISO8601 ou format parsable
            let lhsDate = ISO8601DateFormatter().date(from: lhs.itemAddedDate) ?? .distantPast
            let rhsDate = ISO8601DateFormatter().date(from: rhs.itemAddedDate) ?? .distantPast
            return lhsDate > rhsDate
        })
        
        return items
    }
}
