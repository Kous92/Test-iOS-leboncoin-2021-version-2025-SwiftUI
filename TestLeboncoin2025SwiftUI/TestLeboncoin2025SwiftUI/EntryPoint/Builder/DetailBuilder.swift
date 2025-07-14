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
    
    func buildModule(testMode: Bool, coordinator: Coordinator? = nil) {
        self.testMode = testMode
    
        // Les injections des couches se feront ici
        detailViewModel.coordinator = coordinator as? DetailCoordinator
    }
    
    func getModule() -> DetailViewModel {
        return detailViewModel
    }
}
