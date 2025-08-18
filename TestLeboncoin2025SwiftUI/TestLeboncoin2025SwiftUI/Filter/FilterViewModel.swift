//
//  FilterViewModel.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 12/07/2025.
//

import Observation
import Foundation

@Observable class FilterViewModel {
    weak var coordinator: FilterCoordinator?
    
    var itemCategories: [ItemCategoryViewModel]
    var currentSelectedIndex: Int = 0
    
    // Use case
    private let loadSavedSelectedCategoryUseCase: LoadSavedSelectedCategoryUseCaseProtocol
    private let saveSelectedCategoriesUseCase: SaveSelectedCategoryUseCaseProtocol
    
    init(itemCategories: [ItemCategoryViewModel], loadSavedSelectedCategoryUseCase: LoadSavedSelectedCategoryUseCaseProtocol, saveSelectedCategoriesUseCase: SaveSelectedCategoryUseCaseProtocol) {
        self.itemCategories = itemCategories
        self.loadSavedSelectedCategoryUseCase = loadSavedSelectedCategoryUseCase
        self.saveSelectedCategoriesUseCase = saveSelectedCategoriesUseCase
    }
    
    nonisolated func loadSetting() async {
        do {
            let result = try await self.loadSavedSelectedCategoryUseCase.execute()
            print(result)
            await self.setSelectedCategory(with: result.id)
        } catch APIError.errorMessage(let message) {
            guard message != "nothingSaved" else {
                return
            }
            
            print("Une erreur est survenue lors du chargement de la catégorie.")
            await self.sendErrorMessage(with: message)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveSelectedCategory(at index: Int) {
        print("Catégorie sélectionnée: \(itemCategories[index])")
        
        Task { [weak self] in
            guard let itemCategoryViewModel = self?.itemCategories[index] else {
                print("[FilterViewModel] Erreur lors de la sélection de la cellule")
                return
            }
            
            print("[FilterViewModel] Catégorie sélectionnée: \(itemCategoryViewModel.name): \(itemCategoryViewModel.id)")
            
            do {
                try await self?.saveSelectedCategoriesUseCase.execute(with: itemCategoryViewModel.getDTO())
                await self?.setSelectedCategory(with: itemCategoryViewModel.id)
                
                await MainActor.run { [weak self] in
                    self?.coordinator?.notifyCategoryUpdate()
                }
            } catch APIError.errorMessage(let message) {
                print(message)
            }
        }
    }
    
    private func setSelectedCategory(with itemCategoryId: Int) async {
        currentSelectedIndex = itemCategoryId
    }
}

extension FilterViewModel {
    // MARK: - Logique liste
    func getCurrentSelectedIndex() -> Int {
        return currentSelectedIndex
    }
    
    // Navigation
    func backToPreviousScreen() {
        coordinator?.backToHomeView()
    }
    
    private func sendErrorMessage(with errorMessage: String) {
        print("ERREUR: \(errorMessage)")
        // coordinator?.displayErrorAlert(with: errorMessage)
    }
}
