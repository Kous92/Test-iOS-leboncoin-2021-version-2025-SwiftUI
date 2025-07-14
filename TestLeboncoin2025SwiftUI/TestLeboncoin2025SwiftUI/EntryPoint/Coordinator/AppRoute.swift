//
//  AppRoute.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 30/06/2025.
//

enum AppRoute: Hashable {
    case list
    case detail(ItemViewModel)
    case filter([ItemCategoryViewModel])
}
