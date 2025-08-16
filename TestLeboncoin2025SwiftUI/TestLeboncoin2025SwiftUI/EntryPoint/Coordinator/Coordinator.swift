//
//  Coordinator.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 30/06/2025.
//

import SwiftUI

protocol Coordinator: AnyObject {
    var path: [AppRoute] { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func push(page: AppRoute)
    func pop()
    func popToRoot()
    
    func addChildCoordinator(childCoordinator: Coordinator)
    func removeChildCoordinator(childCoordinator: Coordinator)
}

extension Coordinator {
    func push(page: AppRoute) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    /// Ajoute a un coordinator enfant au parent, le parent ayant une référence vers l'enfant.
    func addChildCoordinator(childCoordinator: Coordinator) {
        print("Adding child coordinator")
        self.childCoordinators.append(childCoordinator)
    }

    /// Supprime un coordinator enfant depuis le parent.
    func removeChildCoordinator(childCoordinator: Coordinator) {
        print("Removing child coordinator")
        // Il est important de vérifier les références entre coordinators, en utilsant === au lieu de ==.
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}

protocol ParentCoordinator: Coordinator, AnyObject {
    var parentCoordinator: Coordinator? { get }
}
