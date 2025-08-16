//
//  MemoryCache.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/08/2025.
//
import Foundation

/**
 Gère le cache en mémoire pour tout type de données afin d’éviter de télécharger plusieurs fois les mêmes données. De plus, en utilisant un `actor` (type référence), il est sûr pour les environnements concurrents, c’est-à-dire avec plusieurs threads (ici via des blocs `Task` et des fonctions `async`), afin d’éviter les conflits d’accès aux données (data races) (comportements imprévisibles, corruptions mémoire, plantages), grâce à un accès synchronisé dédié à ses données isolées. L’accès aux données se fait avec `await` dans des fonctions `async`.

 Ce gestionnaire de cache dispose également d’une date d’expiration afin de permettre à l’application de télécharger de nouvelles données une fois l’intervalle de temps écoulé.
 */
actor MemoryCache<T>: NSCacheType {
    // NSCache est utilisé pour stocker des données en cache et éviter de télécharger plus d'une fois les mêmes données, également thread safe pour éviter la corruption de données lorsqu'il est utilisé par plusieurs threads (tâches).
    let cache: NSCache<NSString, CacheEntry<T>> = .init()
    var keysTracker: KeysTracker<T> = .init()
    let expirationInterval: TimeInterval
    
    init(expirationInterval: TimeInterval) {
        self.expirationInterval = expirationInterval
    }
}
