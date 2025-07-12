//
//  ListBuilder.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 11/07/2025.
//


final class ListBuilder: ModuleBuilder {
    private var testMode = false
    private let listViewModel: ListViewModel
    
    init() {
        self.listViewModel = ListViewModel()
    }
    
    func buildModule(testMode: Bool, coordinator: Coordinator? = nil) {
        self.testMode = testMode
    
        // Les injections des couches se feront ici
        listViewModel.coordinator = coordinator as? ListCoordinator
        print("Coordinator on VM: \(listViewModel.coordinator)")
    }
    
    func getModule() -> ListViewModel {
        return listViewModel
    }
}
