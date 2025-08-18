//
//  ItemListFetchUseCase.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 10/08/2025.
//

nonisolated final class ItemListFetchUseCase: ItemListFetchUseCaseProtocol {
    private let dataRepository: Repository
    
    init(dataRepository: Repository) {
        self.dataRepository = dataRepository
    }
    
    @concurrent nonisolated func execute() async throws -> [ItemViewModel] {
        print("Récupération des items")
        return await handleResult(with: try await dataRepository.fetchItems())
    }
    
    @concurrent private nonisolated func handleResult(with result: [ItemDTO]) async -> [ItemViewModel] {
        await parseViewModels(with: result)
    }
    
    private nonisolated func parseViewModels(with items: [ItemDTO]) async -> [ItemViewModel] {
        var viewModels = [ItemViewModel]()
        items.forEach { viewModels.append(ItemViewModel(withNonIsolated: $0)) }
        
        return viewModels
    }
}
