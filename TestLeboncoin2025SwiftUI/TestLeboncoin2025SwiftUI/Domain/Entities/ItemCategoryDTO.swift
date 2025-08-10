//
//  ItemCategoryDTO.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 14/07/2025.
//

struct ItemCategoryDTO: Sendable {
    let id: Int
    let name: String
    
    init(with itemCategory: ItemCategory) {
        self.id = itemCategory.id
        self.name = itemCategory.name
    }
    
    init(with viewModel: ItemCategoryViewModel) {
        self.id = viewModel.id
        self.name = viewModel.name
    }
    
    func getEncodableItemCategory() -> ItemCategory {
        return ItemCategory(id: self.id, name: self.name)
    }
}

extension ItemCategoryDTO {
    static func getFakeObjectFromItemCategory() -> ItemCategoryDTO {
        return ItemCategoryDTO(with: ItemCategory.getFakeItemCategory())
    }
}
