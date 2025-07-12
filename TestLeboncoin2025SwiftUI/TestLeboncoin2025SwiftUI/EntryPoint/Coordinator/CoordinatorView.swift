//
//  CoordinatorView.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 30/06/2025.
//

import SwiftUI

struct CoordinatorView: View {
    @State private var coordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.start()
                .navigationDestination(for: AppRoute.self) { route in
                    coordinator.destination(page: route)
                }
        }
    }
}
