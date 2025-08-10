//
//  ItemDTO.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 14/07/2025.
//

struct ItemDTO: Sendable {
    let id, categoryID: Int
    let title, description: String
    let price: Int
    let smallImageURL: String
    let thumbImageURL: String
    let creationDate: String
    let isUrgent: Bool
    let siret: String?
    
    init(with item: Item) {
        self.id = item.id
        self.categoryID = item.categoryID
        self.title = item.title
        self.description = item.description
        self.price = item.price
        self.smallImageURL = item.imagesURL.small ?? ""
        self.thumbImageURL = item.imagesURL.thumb ?? ""
        self.creationDate = item.creationDate
        self.isUrgent = item.isUrgent
        self.siret = item.siret
    }
}

extension ItemDTO {
    static func getFakeObjectFromItem() -> ItemDTO {
        return ItemDTO(with: Item.getFakeItem())
    }
}
