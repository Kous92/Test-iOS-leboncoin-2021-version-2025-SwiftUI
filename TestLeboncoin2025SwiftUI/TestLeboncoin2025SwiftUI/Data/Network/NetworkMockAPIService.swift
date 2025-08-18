//
//  NetworkMockAPIService.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 17/08/2025.
//

import Foundation

nonisolated final class NetworkMockAPIService: APIService {
    private let forceFetchFailure: Bool
    
    init(forceFetchFailure: Bool) {
        print("[NetworkMockAPIService] Initialisation")
        self.forceFetchFailure = forceFetchFailure
    }
    
    func fetchItems() async throws -> [Item] {
        guard forceFetchFailure == false else {
            throw APIError.errorMessage("Une erreur est survenue.")
        }
        
        return Item.getFakeItems()
    }
    
    func fetchItemCategories() async throws -> [ItemCategory] {
        guard forceFetchFailure == false else {
            throw APIError.errorMessage("Une erreur est survenue.")
        }
        
        return ItemCategory.getFakeItemCategories()
    }
}
