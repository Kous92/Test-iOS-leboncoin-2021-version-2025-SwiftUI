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
    
    /// Adds a child coordinator to the parent, the parent will have a reference to the child one.
    func addChildCoordinator(childCoordinator: Coordinator) {
        print("Adding child coordinator")
        self.childCoordinators.append(childCoordinator)
    }

    /// Removes a child coordinator from the parent.
    func removeChildCoordinator(childCoordinator: Coordinator) {
        print("Removing child coordinator")
        // Make sure to check reference between coordinators, use === instead of ==.
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}

protocol ParentCoordinator: Coordinator, AnyObject {
    var parentCoordinator: Coordinator? { get }
}
