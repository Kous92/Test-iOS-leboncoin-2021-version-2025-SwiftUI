//
//  AppCoordinator.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 30/06/2025.
//

import SwiftUI
import Observation

@Observable final class AppCoordinator: Coordinator {
    var path = [AppRoute]()
    
    private let listCoordinator = ListCoordinator()
    
    func start() -> some View {
        print("[AppCoordinator] START")
        listCoordinator.parentCoordinator = self
        let listView = listCoordinator.start()
        
        return listView
    }
    
    @ViewBuilder func destination(page: AppRoute) -> some View {
        switch page {
        case .detail:
            DetailView()
        case .filter:
            FilterView()
        default:
            EmptyView()
        }
    }
}
