//
//  Coordinator.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 30/06/2025.
//

import SwiftUI

protocol Coordinator: AnyObject {
    var path: [AppRoute] { get set }
    
    func push(page: AppRoute)
    func pop()
    func popToRoot()
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
}

protocol ParentCoordinator: Coordinator, AnyObject {
    var parentCoordinator: Coordinator? { get }
}
