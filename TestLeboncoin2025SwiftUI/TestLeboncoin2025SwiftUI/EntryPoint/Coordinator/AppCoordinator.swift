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
    var childCoordinators = [Coordinator]()
    
    // Une variable d'état pour la vue racine, qui sera créée une seule fois.
    private var _rootView: AnyView
    
    init() {
        _rootView = AnyView(listCoordinator.start())
        listCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator: listCoordinator)
        
    }
    
    func start() -> some View {
        print("[AppCoordinator] START")
        /*
        listCoordinator.parentCoordinator = self
        let listView = listCoordinator.start()
        */
        
        return _rootView
    }
    
    @ViewBuilder func destination(page: AppRoute) -> some View {
        switch page {
        case .detail(let itemViewModel):
            let detailCoordinator = DetailCoordinator(testMode: false, viewModel: itemViewModel)
            getDetailView(with: detailCoordinator)
        case .filter(let itemCategories):
            let filterCoordinator = FilterCoordinator(testMode: false, categories: itemCategories)
            getFilterView(with: filterCoordinator)
        default:
            EmptyView()
        }
    }
    
    // Type '()' cannot conform to 'View'
    func getDetailView(with detailCoordinator: DetailCoordinator) -> some View {
        detailCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator: detailCoordinator) // Ajoutez-le comme enfant ici
        return detailCoordinator.start()
    }
    
    // Type '()' cannot conform to 'View'
    func getFilterView(with filterCoordinator: FilterCoordinator) -> some View {
        filterCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator: filterCoordinator) // Ajoutez-le comme enfant ici
        return filterCoordinator.start()
    }
}
