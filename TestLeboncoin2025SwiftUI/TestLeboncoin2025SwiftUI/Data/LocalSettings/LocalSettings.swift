//
//  LocalSettings.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 13/08/2025.
//

protocol LocalSettings: Sendable {
    func saveSelectedItemCategory(with itemCategory: ItemCategory) async throws
    func loadSelectedItemCategory() async throws -> ItemCategory
}
