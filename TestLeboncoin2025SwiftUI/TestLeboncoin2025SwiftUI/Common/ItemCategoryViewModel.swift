//
//  ItemCategoryViewModel.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 30/06/2025.
//

struct ItemCategoryViewModel: Sendable, Identifiable, Hashable {
    let id: Int
    let name: String
    private(set) var isSaved: Bool = false
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    /*¨
    init(with itemCategory: ItemCategoryDTO) {
        self.id = itemCategory.id
        self.name = itemCategory.name
    }
    
    func getDTO() -> ItemCategoryDTO {
        return ItemCategoryDTO(with: self)
    }
     */
}

extension ItemCategoryViewModel {
    static func getFakeItemCategory() -> ItemCategoryViewModel {
        return ItemCategoryViewModel(id: 1, name: "Alimentaire")
    }
    
    static func getFakeItemCategories() -> [ItemCategoryViewModel] {
        return [
            ItemCategoryViewModel(id: 1, name: "Alimentaire"),
            ItemCategoryViewModel(id: 2, name: "Informatique"),
            ItemCategoryViewModel(id: 3, name: "Automobile"),
            ItemCategoryViewModel(id: 4, name: "Immobilier"),
            ItemCategoryViewModel(id: 5, name: "Outils")
        ]
    }
}
