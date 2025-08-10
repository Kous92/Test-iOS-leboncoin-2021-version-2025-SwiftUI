//
//  ItemCategoryFetchUseCase.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 14/07/2025.
//

final class ItemCategoryFetchUseCase: ItemCategoryFetchUseCaseProtocol {
    private let dataRepository: Repository
    
    init(dataRepository: Repository) {
        self.dataRepository = dataRepository
    }
    
    func execute() async throws -> [ItemCategoryViewModel] {
        print("Récupération des catégories d'items")
        return handleResult(with: try await dataRepository.fetchItemCategories())
    }
    
    private func handleResult(with result: [ItemCategoryDTO]) -> [ItemCategoryViewModel] {
        parseViewModels(with: result)
    }
    
    private func parseViewModels(with itemCategories: [ItemCategoryDTO]) -> [ItemCategoryViewModel] {
        var viewModels = [ItemCategoryViewModel]()
        
        // On va ajouter en plus des catégories téléchargées, une catégorie générique qui n'aura aucun filtre
        viewModels.append(ItemCategoryViewModel(id: 0, name: "Toutes catégories"))
        itemCategories.forEach { viewModels.append(ItemCategoryViewModel(with: $0)) }
        
        return viewModels
    }
}
