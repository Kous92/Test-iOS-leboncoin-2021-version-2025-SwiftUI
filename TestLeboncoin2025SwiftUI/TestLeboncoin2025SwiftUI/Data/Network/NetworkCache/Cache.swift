//
//  Cache.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/08/2025.
//

import Foundation

// Concrete object conforming to this protocol must to be an actor
protocol Cache: Actor {
    associatedtype T // Generic type
    var expirationInterval: TimeInterval { get }
    
    func setValue(_ value: T?, key: String)
    func value(key: String) -> T?
    func removeValue(key: String)
    func removeAllValues()
}

protocol NSCacheType: Cache {
    var cache: NSCache<NSString, CacheEntry<T>> { get }
    var keysTracker: KeysTracker<T> { get }
}

extension NSCacheType {
    /// Supprime tout le contenu en cache en lien avec la clé
    func removeValue(key: String) {
        keysTracker.keys.remove(key)
        cache.removeObject(forKey: key as NSString)
    }
    
    /// Vide complètement le cache (toutes clés confondues)
    func removeAllValues() {
        keysTracker.keys.removeAll()
        cache.removeAllObjects()
    }
    
    func setValue(_ value: T?, key: String) {
        if let value = value {
            let expiredTimestamp = Date().addingTimeInterval(expirationInterval)
            let cacheEntry = CacheEntry(key: key, value: value, expiredTimestamp: expiredTimestamp)
            insert(cacheEntry)
        } else {
            removeValue(key: key)
        }
    }
    
    func value(key: String) -> T? {
        entry(key: key)?.value
    }
    
    func entry(key: String) -> CacheEntry<T>? {
        guard let entry = cache.object(forKey: key as NSString) else {
            print("[\(Self.Type.self)] Aucun contenu trouvé pour la clé: \(key).")
            return nil
        }
        
        // Vérification de l'expiration du cache. Les données en cache doivent être supprimées après que la date d'expiration soit atteinte.
        guard !entry.isCacheExpired(after: Date()) else {
            print("[\(Self.Type.self)] Cache expiré avec la clé: \(key), suppression du contenu en cache.")
            removeValue(key: key)
            return nil
        }
        
        return entry
    }
    
    func insert(_ entry: CacheEntry<T>) {
        keysTracker.keys.insert(entry.key)
        cache.setObject(entry, forKey: entry.key as NSString)
        print("[\(Self.Type.self)] Cache défini pour la clé: \(entry.key).")
    }
}
