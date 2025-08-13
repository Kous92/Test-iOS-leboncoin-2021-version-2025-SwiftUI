//
//  ListViewModel.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 30/06/2025.
//

import Observation
import Foundation

@Observable final class ListViewModel {
    weak var coordinator: ListCoordinator?
    
    private var itemsViewModels: [ItemViewModel] = []
    private var itemCategories: [ItemCategoryViewModel] = []
    private var filteredItemsViewModels: [ItemViewModel] = []
    private var activeCategory: String = "Toutes catégories"
    
    var isLoading = false
    
    // Use cases
    private let itemCategoryFetchUseCase: ItemCategoryFetchUseCaseProtocol
    private let itemListFetchUseCase: ItemListFetchUseCaseProtocol
    // private let loadSavedSelectedSourceUseCase: LoadSavedSelectedCategoryUseCaseProtocol
    
    // La tâche de recherche
    private var searchQueryContinuation: AsyncStream<String>.Continuation?
    private var searchQueryTask: Task<Void, Never>?
    var searchQuery = "" {
        didSet {
            // À chaque modification du texte de recherche, yield va envoyer la nouvelle valeur
            searchQueryContinuation?.yield(searchQuery)
        }
    }
    
    init(itemCategoryFetchUseCase: ItemCategoryFetchUseCaseProtocol, itemListFetchUseCase: ItemListFetchUseCaseProtocol) {
        self.itemCategoryFetchUseCase = itemCategoryFetchUseCase
        self.itemListFetchUseCase = itemListFetchUseCase
        
        // L'écoute du flux asynchrone de recherche est initialisé
        observeSearchQuery()
        
        // itemsViewModels = ItemViewModel.getFakeItems()
        /*
        itemCategories = [
            ItemCategoryViewModel(id: 0, name: "Toutes catégories"),
            ItemCategoryViewModel(id: 1, name: "Multimédia"),
            ItemCategoryViewModel(id: 2, name: "Immobilier"),
            ItemCategoryViewModel(id: 3, name: "Alimentation"),
            ItemCategoryViewModel(id: 4, name: "Automobile")
        ]
         */
        
        print("Catégories: \(itemCategories.count)")
        print("ListViewModel initialisé.")
    }
    
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
    
    private nonisolated func filterItemsWithSearch() async {
        let itemActor = await ItemActor(with: itemsViewModels, and: itemCategories)
        
        // Depuis une fonction nonisolated, il n'est pas possible de le faire directement depuis le MainActor. Une fois la liste filtrée récupérée, la mutation de la liste est faisable.
        let filteredItems = await itemActor.filterItemsWithSearch(query: searchQuery, activeCategory: self.activeCategory)
            
        await MainActor.run { [weak self] in
            // self?.isLoadingData?(false)
            // self?.onDataUpdated?()
            self?.filteredItemsViewModels = filteredItems
        }
    }
    
    // Ici, on va récupérer depuis le réseau de façon synchronisée les catégories d'articles et les annonces
    func fetchItemList() {
        print("Thread avant entrée dans le Task: ", Thread.currentThread)
        isLoading = true
        
        // Task.detached permet de sortir du main thread et de passer en background thread (tâche de fond)
        Task { [weak self] in
            guard let self else { return }
            
            print("Thread dans le Task avant màj: ", Thread.currentThread)
            print("Main Thread: \(Thread.isOnMainThread)")
            // await self.isLoadingData?(true)
            
            // Les catégories en premier puis la liste d'annonces
            await self.fetchItemCategories()
            print("-> \(self.itemCategories)")
            await self.fetchItems()
            
            // Pour éviter un bug, l'actualisation de la vue se déclenchera après chargement de la catégorie et du filtrage.
            // self.loadSelectedItemCategory()
            print("Thread dans le Task après màj: ", Thread.currentThread)
        }
    }
    
    private func fetchItemCategories() async {
        print("Thread fetchItemCategories: \(Thread.currentThread)")
        
        do {
            itemCategories += try await itemCategoryFetchUseCase.execute()
        } catch APIError.errorMessage(let errorMessage) {
            sendErrorMessage(with: errorMessage)
        } catch {
            sendErrorMessage(with: error.localizedDescription)
        }
    }
    
    private func fetchItems() async {
        print("Thread fetchItems: \(Thread.currentThread)")
        do {
            let parsedItemViewModels = try await itemListFetchUseCase.execute()
            let itemActor = ItemActor(with: parsedItemViewModels, and: itemCategories)
            
            itemsViewModels = await itemActor.parseViewModels()
        } catch APIError.errorMessage(let errorMessage) {
            sendErrorMessage(with: errorMessage)
        } catch {
            sendErrorMessage(with: error.localizedDescription)
        }
        
        filteredItemsViewModels = itemsViewModels
        isLoading = false
    }

    /*
    private func parseViewModels(with itemsViewModels: [ItemViewModel]) async {
        let parsedViewModels = itemsViewModels.map { item in
            let categoryId = self.itemCategories.firstIndex { category in
                guard let id = Int(item.itemCategory) else {
                    return false
                }
                
                return id == category.id
            }
            
            var category = "Inconnu"
            
            if let categoryId {
                // category = self.itemCategoriesViewModels[categoryId].name
            }
            
            return ItemViewModel(smallImage: item.smallImage, thumbImage: item.thumbImage, itemTitle: item.itemTitle, itemCategory: category, itemPrice: item.itemPrice, isUrgent: item.isUrgent, itemDescription: item.itemDescription, itemAddedDate: item.itemAddedDate, siret: item.siret)
        }
        
        // ✅ Tri : urgents en premier, puis triés par date décroissante
        self.itemsViewModels = parsedViewModels.sorted(by: { lhs, rhs in
            if lhs.isUrgent != rhs.isUrgent {
                return lhs.isUrgent && !rhs.isUrgent // urgents d'abord
            }
            
            // Comparer les dates en ISO8601 ou format parsable
            let lhsDate = ISO8601DateFormatter().date(from: lhs.itemAddedDate) ?? .distantPast
            let rhsDate = ISO8601DateFormatter().date(from: rhs.itemAddedDate) ?? .distantPast
            return lhsDate > rhsDate
        })
    }
     */
    
    // MARK: - Logique CollectionView
    func numberOfItems() -> Int {
        return filteredItemsViewModels.count
    }
    
    func getViewModels() -> [ItemViewModel] {
        return filteredItemsViewModels
    }
    
    func getItemCategories() -> [ItemCategoryViewModel] {
        return itemCategories
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

// Logique de navigation
extension ListViewModel {
    private func sendErrorMessage(with errorMessage: String) {
        print(errorMessage)
        // coordinator?.displayErrorAlert(with: errorMessage)
    }
    
    func goToDetailView(selectedViewModelIndex: Int) {
        coordinator?.goToDetailView(with: filteredItemsViewModels[selectedViewModelIndex])
    }
    
    func goToFilterView() {
        coordinator?.goToFilterView(with: itemCategories)
    }
}
