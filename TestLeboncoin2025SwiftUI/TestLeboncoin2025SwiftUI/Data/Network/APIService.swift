//
//  APIService.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/08/2025.
//

protocol APIService: Sendable {
    func fetchItems() async throws -> [Item]
    func fetchItemCategories() async throws -> [ItemCategory]
}
