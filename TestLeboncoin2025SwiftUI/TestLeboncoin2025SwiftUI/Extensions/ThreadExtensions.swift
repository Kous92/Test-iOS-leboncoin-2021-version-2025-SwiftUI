//
//  ThreadExtensions.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/07/2025.
//

import Foundation

/// Des méthodes de débug pour afficher le thread (la tâche) actuel dans une méthode asynchrone du contexte Swift Concurrency
/// Il s'agit d'une solution de contournement pour l'erreur du compilateur: Class property 'current' is unavailable from asynchronous contexts; Thread.current cannot be used from async contexts.
/// Voir ici: https://github.com/swiftlang/swift-corelibs-foundation/issues/5139
extension Thread {
    /// Pour voir avec Swift Concurrency le thread actuel exécuté. Avec Swift 6.2 et l'isolation par défaut sur @MainActor, il est nécessaire d'utiliser nonisolated, afin d'utiliser cette option lors du débug en dehors du @MainActor.
    nonisolated public static var currentThread: Thread {
        return Thread.current
    }
    
    /// Pour voir avec Swift Concurrency si c'est dans le main thread.
    public static var isOnMainThread: Bool {
        return Thread.isMainThread
    }
}
