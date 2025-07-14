//
//  ListCoordinator.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 08/07/2025.
//

import Observation
import SwiftUI

// Attention à la rétention de cycle, le sous-flux ne doit pas retenir la référence avec le parent.
final class ListCoordinator: ParentCoordinator {
    
    var path = [AppRoute]()
    private var builder: ListBuilder
    private let testMode: Bool
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()

    init(testMode: Bool = false) {
        self.builder = ListBuilder()
        self.testMode = testMode
    }
    
    deinit {
        print("[ListCoordinator] Déinit.")
        Task { @MainActor [weak self] in
            self?.parentCoordinator = nil
            print("Parent: \(self?.parentCoordinator == nil ? "Détruit" : "Non détruit")")
        }
    }
    
    func start() -> some View {
        print("[ListCoordinator] Création de la vue liste.")
        // print("Parent: \(parentCoordinator)")
        builder.buildModule(testMode: testMode, coordinator: self)
        let viewModel = builder.getModule()
        return ListView(viewModel: viewModel)
    }
    
    func goToDetailView(with item: ItemViewModel) {
        print("[ListCoordinator] Vers le DetailView")
        // print("Parent: \(parentCoordinator)")
        parentCoordinator?.push(page: .detail(item))
    }
    
    func goToFilterView(with categories: [ItemCategoryViewModel]) {
        print("[ListCoordinator] Vers le FilterView")
        // print("Parent: \(parentCoordinator)")
        parentCoordinator?.push(page: .filter(categories))
    }
}
