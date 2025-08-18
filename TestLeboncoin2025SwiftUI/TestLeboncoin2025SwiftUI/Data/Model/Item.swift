//
//  Item.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 14/07/2025.
//

// Codable car nécessaire pour la mise en cache
nonisolated struct Item: Codable, Sendable {
    let id, categoryID: Int
    let title, description: String
    let price: Int
    let imagesURL: ImagesURL
    let creationDate: String
    let isUrgent: Bool
    let siret: String?
    
    /* Erreur avec Swift 6.2: Conformance of 'Item.CodingKeys' to protocol 'CodingKey' crosses into main actor-isolated code and can cause data races
     -> Dans le cas où l'isolation par défaut est sur le @MainActor, il est obligatoire d'utiliser nonisolated pour l'enum.
     */
    nonisolated enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case description = "description"
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
    
    @MainActor func getDTO() -> ItemDTO {
        return ItemDTO(with: self)
    }
}

// MARK: - ImagesURL
struct ImagesURL: Codable, Sendable {
    let small, thumb: String?
}

extension Item {
    static func getFakeItem() -> Item {
        return Item(
            id: 1,
            categoryID: 1,
            title: "McLaren F1",
            description: "McLaren F1 châssis 052/069, moteur V12 BMW 6,1 litres 627 chevaux.",
            price: 20000000,
            imagesURL: ImagesURL(small: "https://www.robot-forum.com/images/avatars/f1/13688-f1f6a41d04cf0524a9c6e2147a829aeb241c05b5.jpg", thumb: "https://pistonaddict.com/wp-content/uploads/2022/05/mclaren_f1_69-scaled.jpeg"),
            creationDate: "2025-06-04T15:56:59+0000",
            isUrgent: true,
            siret: "431 342 910"
        )
    }
    
    static func getFakeItemWithNilContent() -> Item {
        return Item(
            id: 2,
            categoryID: 2,
            title: "Maillot PSG Collector 2025",
            description: "Maillot collector du PSG avec l'étoile pour la victoire historique du trophée de la Ligue des Champions et le flocage collector Champions of Europe 2025.",
            price: 250,
            imagesURL: ImagesURL(small: "https://www.robot-forum.com/images/avatars/f1/13688-f1f6a41d04cf0524a9c6e2147a829aeb241c05b5.jpg", thumb: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fmrowford.com%2Fproducts%2Fmaillot-psg-victoire-ligue-des-champions-edition-lmitee&psig=AOvVaw1BqXyf1iVlyF08-nmW0X8S&ust=1749129250617000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCLjE6LPs140DFQAAAAAdAAAAABAE"),
            creationDate: "2025-06-04T15:56:59+0000",
            isUrgent: false,
            siret: nil
        )
    }
    
    static func getFakeItems() -> [Item] {
        /// Retourne une liste de faux objets avec tous les champs disponibles. Pour les tests unitaires et previews SwiftUI
        return [
            Item(id: 1, categoryID: 1, title: "iPhone 16 Pro 512 GB noir batterie neuve", description: "iPhone 16 Pro couleur noir, 512 GB, batterie neuve.", price: 1200, imagesURL: ImagesURL(small: "https://img-prd-pim.poorvika.com/prodvarval/Apple-iphone-16-pro-black-titanium-128gb-Front-Back-View-Thumbnail.png", thumb: "https://img-prd-pim.poorvika.com/prodvarval/Apple-iphone-16-pro-black-titanium-128gb-Front-Back-View-Thumbnail.png"), creationDate: "2025-05-18T20:13:31+0000", isUrgent: true, siret: nil),
            Item(id: 2, categoryID: 2, title: "Maillot PSG Collector 2025", description: "Maillot collector du PSG avec l'étoile pour la victoire historique du trophée de la Ligue des Champions et le flocage collector Champions of Europe 2025.", price: 250, imagesURL: ImagesURL(small: "https://images.footballfanatics.com/paris-saint-germain/special-edition-psg-nike-home-stadium-shirt-2024-25-kids-champions-of-europe-2025_ss5_p-203176389+pv-1+u-o6tihsc4adjnejmdff0j+v-of1gibyt9kpk2djlt9nv.jpg?_hv=2&w=900", thumb: "https://images.footballfanatics.com/paris-saint-germain/special-edition-psg-nike-home-stadium-shirt-2024-25-kids-champions-of-europe-2025_ss5_p-203176389+pv-1+u-o6tihsc4adjnejmdff0j+v-of1gibyt9kpk2djlt9nv.jpg?_hv=2&w=900"), creationDate: "2025-06-04T15:56:59+0000", isUrgent: false, siret: nil),
            Item(id: 3, categoryID: 3, title: "McLaren F1", description: "McLaren F1 châssis 052/069, moteur V12 BMW 6,1 litres 627 chevaux.", price: 20000000, imagesURL: ImagesURL(small: "https://www.robot-forum.com/images/avatars/f1/13688-f1f6a41d04cf0524a9c6e2147a829aeb241c05b5.jpg", thumb: "https://pistonaddict.com/wp-content/uploads/2022/05/mclaren_f1_69-scaled.jpeg"), creationDate: "2025-06-04T15:56:59+0000", isUrgent: true, siret: "431 342 910"),
            Item(id: 4, categoryID: 1, title: "iPhone 16 Pro Max 256 GB sable neuf", description: "iPhone 16 Pro Max neuf couleur sable, 256 GB, batterie neuve, non déballé dans sa boîte d'origine, facture Apple officielle incluse.", price: 1400, imagesURL: ImagesURL(small: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQe8p5q6MaZgbww-KSw3mAHIXkcPTRaeJC8y6G8QS6ypX88cKrqOhyxpn1qCyE8iMmolo6UnDXgSKBqnlO9LLxkBCP26ZkSzzph_cofqFTpkf3yMtPnUWh54w0P6-phPtV4Q_wHOg&usqp=CAc", thumb: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQe8p5q6MaZgbww-KSw3mAHIXkcPTRaeJC8y6G8QS6ypX88cKrqOhyxpn1qCyE8iMmolo6UnDXgSKBqnlO9LLxkBCP26ZkSzzph_cofqFTpkf3yMtPnUWh54w0P6-phPtV4Q_wHOg&usqp=CAc"), creationDate: "2025-05-19T17:42:29+0000", isUrgent: true, siret: nil),
            Item(id: 5, categoryID: 3, title: "Peugeot 208 GT", description: "Peugeot 208 GT année 2025 bleue toutes options.", price: 1200, imagesURL: ImagesURL(small: "https://www.peugeottalk.de/cms/images/avatars/7c/3752-7cfd12ec9a0125062609ecb2bae5fce78847ae7d.png", thumb: "https://www.peugeottalk.de/cms/images/avatars/7c/3752-7cfd12ec9a0125062609ecb2bae5fce78847ae7d.png"), creationDate: "2025-05-18T20:13:31+0000", isUrgent: true, siret: nil),
            Item(id: 6, categoryID: 4, title: "Appartement duplex Paris 15ème Convention", description: "Appartement 5 pièces en duplex situé dans Paris 15ème, rue de la Convention. Superficie de 175 m2, avec grande terrasse dotée d'une vue imprenable sur Paris.", price: 2300000, imagesURL: ImagesURL(small: "https://cf.bstatic.com/xdata/images/hotel/max1024x768/258858602.jpg?k=85821b7952d70a6569617ba2ad412b3566b5d4d4dcf2c0a0e71a2d4d7042f0b5&o=&hp=1", thumb: "https://cf.bstatic.com/xdata/images/hotel/max1024x768/258858602.jpg?k=85821b7952d70a6569617ba2ad412b3566b5d4d4dcf2c0a0e71a2d4d7042f0b5&o=&hp=1"), creationDate: "2025-05-18T20:13:31+0000", isUrgent: true, siret: "552 141 533 00018"),
            Item(id: 7, categoryID: 5, title: "Pot de crème de noisettes grillées El Mordjene 700g", description: "Pot de crème de noisettes grillées El Mordjene 700g de la marque CEBON, goût Kinder Bueno.", price: 15, imagesURL: ImagesURL(small: "https://lessaveursdeurope.ca/cdn/shop/files/2901391F-0E9C-4B3D-B5D4-7213ECD3847F.jpg?v=1746985785&width=900", thumb: "https://lessaveursdeurope.ca/cdn/shop/files/2901391F-0E9C-4B3D-B5D4-7213ECD3847F.jpg?v=1746985785&width=900"), creationDate: "2025-05-18T20:13:31+0000", isUrgent: false, siret: nil),
            Item(id: 8, categoryID: 5, title: "Pot de pâte à tartiner aux noisettes et cacao El Mordjene 700g", description: "Pot de pâte à tartiner aux noisettes et cacao El Mordjene 700g de la marque CEBON, goût Cacao (type Ferrero Rocher), moins sucré que le Nutella.", price: 15, imagesURL: ImagesURL(small: "https://f.nooncdn.com/p/pzsku/ZD34C2FCBA93EA1744CA6Z/45/1746252389/f0155059-328f-441a-b694-477da1a669cc.jpg?width=800", thumb: "https://f.nooncdn.com/p/pzsku/ZD34C2FCBA93EA1744CA6Z/45/1746252389/f0155059-328f-441a-b694-477da1a669cc.jpg?width=800"), creationDate: "2025-05-29T20:20:12+0000", isUrgent: false, siret: nil)
        ]
    }
}
