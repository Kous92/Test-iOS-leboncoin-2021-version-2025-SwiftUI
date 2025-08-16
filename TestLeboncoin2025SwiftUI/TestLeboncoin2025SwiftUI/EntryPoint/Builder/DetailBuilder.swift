//
//  DetailBuilder.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 13/07/2025.
//

final class DetailBuilder: ModuleBuilder {
    private var testMode = false
    private let detailViewModel: DetailViewModel
    
    init(with viewModel: ItemViewModel) {
        self.detailViewModel = DetailViewModel(with: viewModel)
    }
    
    // Ici, il n'y a pas de logique spécifique, seulement un ViewModel avec les données de vue injecté via l'initialiseur
    func buildModule(testMode: Bool, coordinator: Coordinator? = nil) {
        self.testMode = testMode
    
        // Pour le MVVM-C, le ViewModel aura une référence avec le coordinator pour la navigation
        detailViewModel.coordinator = coordinator as? DetailCoordinator
    }
    
    // Permet au Coordinator d'injecter la dépendance à la vue pour une mise en place complète des couches de la Clean Architecture
    func getModule() -> DetailViewModel {
        return detailViewModel
    }
}
