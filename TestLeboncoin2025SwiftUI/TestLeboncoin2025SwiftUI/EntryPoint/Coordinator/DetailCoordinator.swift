//
//  DetailCoordinator.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/07/2025.
//

import SwiftUI

final class DetailCoordinator: Coordinator {    
    var path = [AppRoute]()
    private var builder: DetailBuilder
    private let testMode: Bool
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    
    init(testMode: Bool = false, viewModel: ItemViewModel) {
        self.builder = DetailBuilder(with: viewModel)
        self.testMode = testMode
    }
    
    deinit {
        print("[DetailCoordinator] Déinitialisation.")
        Task { @MainActor [weak self] in
            self?.parentCoordinator = nil
            print("Référence parent: \(self?.parentCoordinator == nil ? "Détruite" : "Non détruite")")
        }
    }
    
    func start() -> some View {
        print("[DetailCoordinator] Création de la vue détail.")
        print("Parent: \(parentCoordinator)")
        builder.buildModule(testMode: testMode, coordinator: self)
        let viewModel = builder.getModule()
        return DetailView(viewModel: viewModel)
    }
    
    func backToHomeView() {
        parentCoordinator?.removeChildCoordinator(childCoordinator: self)
    }
}
