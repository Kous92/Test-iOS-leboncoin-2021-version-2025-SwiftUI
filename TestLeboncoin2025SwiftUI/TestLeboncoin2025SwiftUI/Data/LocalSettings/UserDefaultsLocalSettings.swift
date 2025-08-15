//
//  UserDefaultsLocalSettings.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 13/08/2025.
//

import Foundation

final class UserDefaultsLocalSettings: LocalSettings {
    func saveSelectedItemCategory(with itemCategory: ItemCategory) async throws {
        print("[UserDefaultsLocalSettings] Sauvegarde de la catégorie: \(itemCategory.name), id: \(itemCategory.id)")
        
        do {
            // L'encodage est nécessaire avant sauvegarde d'un objet
            let encoder = JSONEncoder()
            let data = try encoder.encode(itemCategory)

            // Sauvegarde
            UserDefaults.standard.set(data, forKey: "savedSource")
        } catch {
            throw APIError.errorMessage("Une erreur est survenue lors de l'encodage de la catégorie à sauvegarder. \(error)")
        }
    }
    
    func loadSelectedItemCategory() async throws -> ItemCategory {
        print("[UserDefaultsLocalSettings] Chargement de la catégorie sauvegardée.")
        
        if let data = UserDefaults.standard.data(forKey: "savedSource") {
            do {
                // Le chargement d'un objet se fait avec un décodage
                let decoder = JSONDecoder()
                let itemCategory = try decoder.decode(ItemCategory.self, from: data)
                
                return itemCategory
            } catch {
                print("[UserDefaultsLocalSettings] Une erreur est survenue lors du décodage de la catégorie à charger. (\(error))")
                throw APIError.errorMessage("")
            }
        }
        
        throw APIError.errorMessage("nothingSaved")
    }
}
