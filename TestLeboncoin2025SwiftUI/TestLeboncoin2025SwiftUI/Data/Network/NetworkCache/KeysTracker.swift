//
//  KeysTracker.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/08/2025.
//
import Foundation

/// Suit toutes les clés utilisées avec NSCache pour charger et sauvegarder des données.
nonisolated final class KeysTracker<T>: NSObject, NSCacheDelegate {
    var keys = Set<String>()
    
    // Depuis NSCacheDelegate, déclenché lorsqu'un objet sera supprimé du cache
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        guard let entry = obj as? CacheEntry<T> else {
            return
        }
        
        keys.remove(entry.key)
    }
}
