//
//  ListViewModel.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 30/06/2025.
//

import Observation
import Foundation
import Combine

@Observable final class ListViewModel {
    var coordinator: ListCoordinator?
    
    private var itemsViewModels: [ItemViewModel] = []
    private var itemCategories: [ItemCategoryViewModel] = []
    private var filteredItemsViewModels: [ItemViewModel] = []
    private var activeCategory: String = "Toutes catégories"
    
    private var cancellables: Set<AnyCancellable> = []
    
    // La tâche de recherche
    private var searchTask: Task<Void, Never>?
    private var searchQueryContinuation: AsyncStream<String>.Continuation?
    private var searchQueryTask: Task<Void, Never>?
    var searchQuery = "" {
        didSet {
            // À chaque modification du texte de recherche, yield va envoyer la nouvelle valeur
            searchQueryContinuation?.yield(searchQuery)
        }
    }
    
    init() {
        // L'écoute du flux asynchrone de recherche est initialisé
        observeSearchQuery()
        
        itemsViewModels = ItemViewModel.getFakeItems()
        filteredItemsViewModels = itemsViewModels
        
        
        print("ListViewModel initialisé.")
    }
    
    /*
    nonisolated private func finishSearchTask() {
        searchQueryTask?.cancel()
        searchQueryContinuation?.finish()
    }
    */
    
    // Si l'objet est détruit, alors la tâche asynchrone de recherche doit être stoppée. ATTENTION: deinit est nonisolated par défaut. Aussi, isoler le deinit sur le MainActor requiert iOS 18.4 ou ultérieur pour fonctionner avec Swift 6.2. Il faudra explicitement isoler les actions dans le MainActor par le biais d'une tâche.
    deinit {
        Task { @MainActor [weak self] in
            self?.searchQueryTask?.cancel()
            self?.searchQueryContinuation?.finish()
        }
    }
    
    private func observeSearchQuery() {
        let stream = AsyncStream<String> { continuation in
            self.searchQueryContinuation = continuation
        }
        
        searchQueryTask = Task { [weak self] in
            guard let self else { return }
            
            var lastValue: String? = nil
            
            for await query in stream {
                print("Thread Task search \(Thread.currentThread)")
                print("Query: \(self.searchQuery)")
                // Ignore les doublons
                guard query != lastValue else { continue }
                lastValue = query
                
                // Debounce 300 ms
                try? await Task.sleep(for: .milliseconds(300))
                
                // Ignore si la valeur n’a pas changé pendant le délai
                guard lastValue == searchQuery else {
                    continue
                }
                
                // Filtrage de la liste de recherche
                await filterItemsWithSearch()
            }
        }
    }
    
    private func filterItemsWithSearch() async {
        if searchQuery.isEmpty {
            filteredItemsViewModels = itemsViewModels
        } else {
            filteredItemsViewModels = itemsViewModels.filter { viewModel in
                let title = viewModel.itemTitle.lowercased()
                return title.contains(searchQuery.lowercased())
            }
        }
        
        // Il faut conserver le filtre de catégorie s'il est mis en application (excepté le générique)
        if activeCategory != "Toutes catégories" {
            filteredItemsViewModels = filteredItemsViewModels.filter { itemViewModel in
                return itemViewModel.itemCategory == activeCategory
            }
        }
        
        /*
        await MainActor.run { [weak self] in
            // self?.isLoadingData?(false)
            // self?.onDataUpdated?()
        }
         */
    }
    /*
    // MARK: - Combine Search Debounce
    private func observeSearchQuery() {
        $searchQuery
            .removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applyFilters()
            }
            .store(in: &cancellables)
    }
     */
    // MARK: - Logique CollectionView
    func numberOfItems() -> Int {
        return filteredItemsViewModels.count
    }
    
    func getViewModels() -> [ItemViewModel] {
        return filteredItemsViewModels
    }
    
    /*/
    func getItemViewModel(at indexPath: IndexPath) -> ItemViewModel? {
        // On vérifie bien qu'il y a au moins une cellule dans la liste après filtrage, sinon ça il y aura un crash
        let cellCount = filteredItemsViewModels.count
        
        guard cellCount > 0, indexPath.item < cellCount else {
            return nil
        }
        
        return filteredItemsViewModels[indexPath.item]
    }
     */
}

extension ListViewModel {
    private func sendErrorMessage(with errorMessage: String) {
        print(errorMessage)
        // coordinator?.displayErrorAlert(with: errorMessage)
    }
    
    func goToDetailView(selectedViewModelIndex: Int) {
        coordinator?.goToDetailView(with: filteredItemsViewModels[selectedViewModelIndex])
    }
    
    func goToFilterView() {
        coordinator?.goToFilterView()
    }
}
