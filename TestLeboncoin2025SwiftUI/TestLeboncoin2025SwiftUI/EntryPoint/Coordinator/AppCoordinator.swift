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
        // Ici, on initialise une seule fois la vue. Sinon, si on le fait dans start(), ça se fera en permance et ça perturbera le fonctionnement de l'application.
        _rootView = AnyView(listCoordinator.start())
        listCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator: listCoordinator)
    }
    
    // La fonction se déclenche à chaque apparition de la vue principale, ce qui est contraignant en SwiftUI. Il faut donc récupérer la variable d'état contenant la vue racine initialisée.
    func start() -> some View {
        print("[AppCoordinator] START")
        
        return _rootView
    }
    
    // Les destinations parmi les 2 écrans possibles depuis la vue principale.
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
    
    func getDetailView(with detailCoordinator: DetailCoordinator) -> some View {
        detailCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator: detailCoordinator)
        return detailCoordinator.start()
    }
    
    func getFilterView(with filterCoordinator: FilterCoordinator) -> some View {
        filterCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator: filterCoordinator)
        return filterCoordinator.start()
    }
}
