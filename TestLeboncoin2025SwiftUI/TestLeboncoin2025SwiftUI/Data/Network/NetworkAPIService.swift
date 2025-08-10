//
//  NetworkAPIService.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/08/2025.
//

import Foundation

nonisolated final class NetworkAPIService: APIService {
    private let itemCache = FileCache<[Item]>(fileName: "item_cache_data", expirationInterval: 28800) // 8 heures avant expiration
    private let itemCategoryCache = FileCache<[ItemCategory]>(fileName: "item_category_cache_data", expirationInterval: 28800) // 8 heures avant expiration
    
    init() {
        Task(priority: .userInitiated) { [weak self] in
            guard let self else { return }
            
            print("[NetworkAPIService] Initialisation des fichiers de cache")
            await self.itemCache.loadFromDisk()
            await self.itemCategoryCache.loadFromDisk()
        }
    }
    
    func fetchItems() async throws -> [Item] {
        return try await fetchItemData(endpoint: .fetchItems)
    }
    
    func fetchItemCategories() async throws -> [ItemCategory] {
        return try await fetchItemCategoriesData(endpoint: .fetchItemCategories)
    }
    
    /// It fetches the data with caching option. If existing data was already downloaded (and not expired), the data will be retrieved from cache.
    private func fetchItemData(endpoint: APIEndpoint) async throws -> [Item] {
        print("[NetworkAPIService] Vérification des données en cache pour la clé: \(endpoint.path)")
        
        if let items = await itemCache.value(key: endpoint.path) {
            print("[NetworkAPIService] Données en cache trouvées, \(items.count) items disponible. Le téléchargement est ignoré.")
            return items
        }
        
        print("[NetworkAPIService] Pas de données en cache avec la clé \(endpoint.path)")
        
        return try await handleItemsOutput(with: await getRequest(endpoint: endpoint))
    }
    
    /// It fetches the data with caching option. If existing data was already downloaded (and not expired), the data will be retrieved from cache.
    private func fetchItemCategoriesData(endpoint: APIEndpoint) async throws -> [ItemCategory] {
        print("[NetworkAPIService] Vérification des données en cache pour la clé: \(endpoint.path)")
        
        if let items = await itemCategoryCache.value(key: endpoint.path) {
            print("[NetworkAPIService] Données en cache trouvées, \(items.count) items disponible. Le téléchargement est ignoré.")
            return items
        }
        
        print("[NetworkAPIService] Pas de données en cache avec la clé \(endpoint.path)")
        
        return try await handleItemsCategoriesOutput(with: await getRequest(endpoint: endpoint))
    }
    
    private func handleItemsOutput(with output: [Item]) async -> [Item] {
        print("[NetworkAPIService] Sauvegarde de \(output.count) items téléchargées dans le cache local, clé: \(APIEndpoint.fetchItems.path)")
        await itemCache.setValue(output, key: APIEndpoint.fetchItems.path)
        await itemCache.saveToDisk()
        
        return output
    }
    
    private func handleItemsCategoriesOutput(with output: [ItemCategory]) async -> [ItemCategory] {
        print("[NetworkAPIService] Sauvegarde de \(output.count) catégories téléchargées dans le cache local, clé: \(APIEndpoint.fetchItemCategories.path)")
        await itemCategoryCache.setValue(output, key: APIEndpoint.fetchItemCategories.path)
        await itemCategoryCache.saveToDisk()
        
        return output
    }
    
    private func getRequest<T: Decodable & Sendable>(endpoint: APIEndpoint) async throws -> T {
        // Perform the network request and decode the data
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            throw APIError.errorMessage("URL invalide")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = (response as? HTTPURLResponse) else {
            print("[NetworkAPIService] Erreur réseau.")
            throw APIError.errorMessage("Erreur réseau")
        }
        
        guard httpResponse.statusCode == 200 else {
            print("[NetworkAPIService] Erreur code \(httpResponse.statusCode).")
            switch httpResponse.statusCode {
            case 404:
                throw APIError.errorMessage("Ressource non trouvée")
            case 500:
                throw APIError.errorMessage("Erreur serveur")
            default:
                throw APIError.errorMessage("Erreur inconnue")
            }
        }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            throw APIError.errorMessage("Failed to decode data from network due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            throw APIError.errorMessage("Failed to decode data from network due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            throw APIError.errorMessage("Failed to decode data from network due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            throw APIError.errorMessage("Failed to decode data from network from bundle because it appears to be invalid JSON")
        } catch {
            throw APIError.errorMessage("Failed to decode data from network: \(error.localizedDescription)")
        }
    }
}
