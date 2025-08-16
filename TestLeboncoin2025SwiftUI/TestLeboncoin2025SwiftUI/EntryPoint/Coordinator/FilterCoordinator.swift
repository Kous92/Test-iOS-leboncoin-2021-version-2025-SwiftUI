//
//  FilterCoordinator.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/07/2025.
//

import SwiftUI

final class FilterCoordinator: Coordinator {
    var path = [AppRoute]()
    private var builder: FilterBuilder
    private let testMode: Bool
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    
    init(testMode: Bool = false, categories: [ItemCategoryViewModel]) {
        self.builder = FilterBuilder(with: categories)
        self.testMode = testMode
    }
    
    deinit {
        print("[FilterCoordinator] Déinitialisation.")
        Task { @MainActor [weak self] in
            self?.parentCoordinator = nil
            print("Référence parent: \(self?.parentCoordinator == nil ? "Détruite" : "Non détruite")")
        }
    }
    
    // Important, pour le module à créer, buildModule en premier pour créer le ViewModel avec les couches associées, puis injecter le ViewModel à la vue en le récupérant via getModule()
    func start() -> some View {
        print("[FilterCoordinator] Création de la vue filtre.")
        
        builder.buildModule(testMode: testMode, coordinator: self)
        let viewModel = builder.getModule()
        return FilterView(viewModel: viewModel)
    }
    
    func backToHomeView() {
        parentCoordinator?.removeChildCoordinator(childCoordinator: self)
    }
    
    func notifyCategoryUpdate() {
        if let listCoordinator = parentCoordinator?.childCoordinators.first(where: { $0 is ListCoordinator }) as? ListCoordinator {
            print("[FilterCoordinator]: Une mise à jour de catégorie aura lieu.")
            listCoordinator.notifyCategoryUpdate()
        }
    }
}
