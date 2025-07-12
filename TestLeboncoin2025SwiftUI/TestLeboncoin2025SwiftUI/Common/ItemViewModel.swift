//
//  ItemViewModel.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 30/06/2025.
//

import Foundation

struct ItemViewModel: Sendable, Identifiable, Hashable {
    var id = UUID()
    let smallImage: String
    let thumbImage: String
    let itemTitle: String
    let itemCategory: String
    let itemPrice: Int
    let isUrgent: Bool
    let itemDescription: String
    var itemAddedDate: String
    let siret: String?
    
    init(smallImage: String = "?", thumbImage: String = "?", itemTitle: String = "?", itemCategory: String = "?", itemPrice: Int = 0, isUrgent: Bool = false, itemDescription: String = "?", itemAddedDate: String = "?", siret: String? = nil) {
        self.smallImage = smallImage
        self.thumbImage = thumbImage
        self.itemTitle = itemTitle
        self.itemCategory = itemCategory
        self.itemPrice = itemPrice
        self.isUrgent = isUrgent
        self.itemDescription = itemDescription
        self.itemAddedDate = itemAddedDate
        self.siret = siret
    }
    
    /*
    init(with item: ItemDTO) {
        self.smallImage = item.smallImageURL
        self.thumbImage = item.thumbImageURL
        self.itemTitle = item.title
        self.itemCategory = "\(item.categoryID)"
        self.itemPrice = item.price
        self.isUrgent = item.isUrgent
        self.itemDescription = item.description
        self.itemAddedDate = item.creationDate
        self.siret = item.siret
    }
     */
}

extension ItemViewModel {
    /// Returns a fake object with all available fields. For unit tests and SwiftUI previews
    static func getFakeItem() -> ItemViewModel {
        return ItemViewModel(smallImage: "https://img-prd-pim.poorvika.com/prodvarval/Apple-iphone-16-pro-black-titanium-128gb-Front-Back-View-Thumbnail.png", thumbImage: "https://img-prd-pim.poorvika.com/prodvarval/Apple-iphone-16-pro-black-titanium-128gb-Front-Back-View-Thumbnail.png", itemTitle: "iPhone 16 Pro 512 GB noir batterie neuve", itemCategory: "Multimédia", itemPrice: 1200, isUrgent: true, itemDescription: "iPhone 16 Pro couleur noir, 512 GB, batterie neuve.", itemAddedDate: "2025-05-18T20:13:31+0000")
    }
    
    static func getFakeNonUrgentItem() -> ItemViewModel {
        ItemViewModel(smallImage: "https://lessaveursdeurope.ca/cdn/shop/files/2901391F-0E9C-4B3D-B5D4-7213ECD3847F.jpg?v=1746985785&width=900", thumbImage: "https://lessaveursdeurope.ca/cdn/shop/files/2901391F-0E9C-4B3D-B5D4-7213ECD3847F.jpg?v=1746985785&width=900", itemTitle: "Pot de crème de noisettes grillées El Mordjene 700g", itemCategory: "Alimentation", itemPrice: 15, isUrgent: false, itemDescription: "Pot de crème de noisettes grillées El Mordjene 700g de la marque CEBON, goût Kinder Bueno.", itemAddedDate: "2025-05-18T20:13:31+0000")
    }
    
    static func getFakeProItem() -> ItemViewModel {
        return ItemViewModel(smallImage: "https://www.peugeottalk.de/cms/images/avatars/7c/3752-7cfd12ec9a0125062609ecb2bae5fce78847ae7d.png", itemTitle: "Peugeot 208 GT", itemCategory: "Véhicule", itemPrice: 21000, isUrgent: false, itemDescription: "Peugeot 208 GT année 2025 bleue toutes options.", itemAddedDate: "2025-05-22T11:17:45+0000", siret: "450 897 558 00026")
    }
    
    static func getFakeProUrgentItem() -> ItemViewModel {
        ItemViewModel(smallImage: "https://cf.bstatic.com/xdata/images/hotel/max1024x768/258858602.jpg?k=85821b7952d70a6569617ba2ad412b3566b5d4d4dcf2c0a0e71a2d4d7042f0b5&o=&hp=1", thumbImage: "https://cf.bstatic.com/xdata/images/hotel/max1024x768/258858602.jpg?k=85821b7952d70a6569617ba2ad412b3566b5d4d4dcf2c0a0e71a2d4d7042f0b5&o=&hp=1", itemTitle: "Appartement duplex Paris 15ème Convention", itemCategory: "Immobilier", itemPrice: 2300000, isUrgent: true, itemDescription: "Appartement 5 pièces en duplex situé dans Paris 15ème, rue de la Convention. Superficie de 175 m2, avec grande terrasse dotée d'une vue imprenable sur Paris.", itemAddedDate: "2025-05-18T20:13:31+0000", siret: "552 141 533 00018")
    }
    
    static func getFakeItems() -> [ItemViewModel] {
        return [
            ItemViewModel(smallImage: "https://img-prd-pim.poorvika.com/prodvarval/Apple-iphone-16-pro-black-titanium-128gb-Front-Back-View-Thumbnail.png", thumbImage: "https://img-prd-pim.poorvika.com/prodvarval/Apple-iphone-16-pro-black-titanium-128gb-Front-Back-View-Thumbnail.png", itemTitle: "iPhone 16 Pro 512 GB noir batterie neuve", itemCategory: "Multimédia", itemPrice: 1200, isUrgent: true, itemDescription: "iPhone 16 Pro couleur noir, 512 GB, batterie neuve.", itemAddedDate: "2025-05-18T20:13:31+0000"),
            ItemViewModel(smallImage: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQe8p5q6MaZgbww-KSw3mAHIXkcPTRaeJC8y6G8QS6ypX88cKrqOhyxpn1qCyE8iMmolo6UnDXgSKBqnlO9LLxkBCP26ZkSzzph_cofqFTpkf3yMtPnUWh54w0P6-phPtV4Q_wHOg&usqp=CAc", thumbImage: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQe8p5q6MaZgbww-KSw3mAHIXkcPTRaeJC8y6G8QS6ypX88cKrqOhyxpn1qCyE8iMmolo6UnDXgSKBqnlO9LLxkBCP26ZkSzzph_cofqFTpkf3yMtPnUWh54w0P6-phPtV4Q_wHOg&usqp=CAc", itemTitle: "iPhone 16 Pro Max 256 GB sable neuf", itemCategory: "Multimédia", itemPrice: 1400, isUrgent: true, itemDescription: "iPhone 16 Pro Max neuf couleur sable, 256 GB, batterie neuve, non déballé dans sa boîte d'origine, facture Apple officielle incluse.", itemAddedDate: "2025-05-19T17:42:29+0000"),
            ItemViewModel(smallImage: "https://www.peugeottalk.de/cms/images/avatars/7c/3752-7cfd12ec9a0125062609ecb2bae5fce78847ae7d.png", itemTitle: "Peugeot 208 GT", itemCategory: "Véhicule", itemPrice: 21000, isUrgent: false, itemDescription: "Peugeot 208 GT année 2025 bleue toutes options.", itemAddedDate: "2025-05-22T11:17:45+0000", siret: "450 897 558 00026"),
            ItemViewModel(smallImage: "https://s.yimg.com/ny/api/res/1.2/xeNHeqSESrNc0Q1Jmgc0VA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MDtoPTY0MA--/https://media.zenfs.com/fr/rmc_sport_articles_552/441c8d09cef6cd7530aeda85b01fc6a6", itemTitle: "Maillot collector du PSG Champions of Europe 2025", itemCategory: "Mode", itemPrice: 200, isUrgent: true, itemDescription: "Maillot collector du PSG avec l'étoile pour la victoire historique du trophée de la Ligue des Champions et le flocage collector Champions of Europe 2025.", itemAddedDate: "2025-05-02T18:17:53+0000"),
            ItemViewModel(smallImage: "https://cf.bstatic.com/xdata/images/hotel/max1024x768/258858602.jpg?k=85821b7952d70a6569617ba2ad412b3566b5d4d4dcf2c0a0e71a2d4d7042f0b5&o=&hp=1", itemTitle: "Appartement duplex Paris 15ème Convention", itemCategory: "Immobilier", itemPrice: 2300000, isUrgent: true, itemDescription: "Appartement 5 pièces en duplex situé dans Paris 15ème, rue de la Convention. Superficie de 175 m2, avec grande terrasse dotée d'une vue imprenable sur Paris.", itemAddedDate: "2025-05-18T20:13:31+0000", siret: "552 141 533 00018"),
            ItemViewModel(smallImage: "https://lessaveursdeurope.ca/cdn/shop/files/2901391F-0E9C-4B3D-B5D4-7213ECD3847F.jpg?v=1746985785&width=900", thumbImage: "https://lessaveursdeurope.ca/cdn/shop/files/2901391F-0E9C-4B3D-B5D4-7213ECD3847F.jpg?v=1746985785&width=900", itemTitle: "Pot de crème de noisettes grillées El Mordjene 700g", itemCategory: "Alimentation", itemPrice: 15, isUrgent: false, itemDescription: "Pot de crème de noisettes grillées El Mordjene 700g de la marque CEBON, goût Kinder Bueno.", itemAddedDate: "2025-05-18T20:13:31+0000"),
            ItemViewModel(smallImage: "https://f.nooncdn.com/p/pzsku/ZD34C2FCBA93EA1744CA6Z/45/1746252389/f0155059-328f-441a-b694-477da1a669cc.jpg?width=800", thumbImage: "https://f.nooncdn.com/p/pzsku/ZD34C2FCBA93EA1744CA6Z/45/1746252389/f0155059-328f-441a-b694-477da1a669cc.jpg?width=800", itemTitle: "Pot de pâte à tartiner aux noisettes et cacao El Mordjene 700g", itemCategory: "Alimentation", itemPrice: 15, isUrgent: false, itemDescription: "Pot de pâte à tartiner aux noisettes et cacao El Mordjene 700g de la marque CEBON, goût Cacao (type Ferrero Rocher), moins sucré que le Nutella.", itemAddedDate: "2025-05-29T20:20:12+0000")
            ]
    }
}
