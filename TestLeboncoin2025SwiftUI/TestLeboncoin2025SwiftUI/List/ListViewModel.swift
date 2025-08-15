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
    private let loadSavedSelectedCategoryUseCase: LoadSavedSelectedCategoryUseCaseProtocol
    
    // La tâche de recherche
    private var searchQueryContinuation: AsyncStream<String>.Continuation?
    private var searchQueryTask: Task<Void, Never>?
    var searchQuery = "" {
        didSet {
            // À chaque modification du texte de recherche, yield va envoyer la nouvelle valeur
            searchQueryContinuation?.yield(searchQuery)
        }
    }
    
    init(itemCategoryFetchUseCase: ItemCategoryFetchUseCaseProtocol, itemListFetchUseCase: ItemListFetchUseCaseProtocol, loadSavedSelectedCategoryUseCase: LoadSavedSelectedCategoryUseCaseProtocol) {
        self.itemCategoryFetchUseCase = itemCategoryFetchUseCase
        self.itemListFetchUseCase = itemListFetchUseCase
        self.loadSavedSelectedCategoryUseCase = loadSavedSelectedCategoryUseCase
        
        // L'écoute du flux asynchrone de recherche est initialisé
        observeSearchQuery()
        print("ListViewModel initialisé.")
    }
    
    // Si l'objet est détruit, alors la tâche asynchrone de recherche doit être stoppée. ATTENTION: deinit est nonisolated par défaut. Aussi, isoler le deinit sur le MainActor requiert iOS 18.4 ou ultérieur pour fonctionner avec Swift 6.2. Il faudra explicitement isoler les actions dans le MainActor par le biais d'une tâche.
    deinit {
        Task { @MainActor [weak self] in
            self?.searchQueryTask?.cancel()
            self?.searchQueryContinuation?.finish()
        }
    }
    
    // Dès qu'il y a eu une sélection du filtre depuis FilterViewController, se déclenche via les delegates de FilterCoordinator et ListCoordinator. Le but étant de charger le nouveau filtre et l'appliquer dès que nécessaire pour éviter certains bugs et soucis de synchronisation.
    func updateCategoryFilter() {
        print(">>> Prêt pour appliquer le filtre de la catégorie dans la liste.")
        isLoading = true
        loadSelectedItemCategory()
    }
    
    nonisolated func loadSelectedItemCategory() {
        Task { [weak self] in
            do {
                let itemCategory = try await self?.loadSavedSelectedCategoryUseCase.execute()
                
                await MainActor.run { [weak self] in
                    self?.activeCategory = itemCategory?.name ?? "Toutes catégories"
                }
                
                await self?.filterItemsByCategory(with: itemCategory?.name ?? "Toutes catégories")
            } catch APIError.errorMessage(let message) {
                print("\(message). La catégorie par défaut sera appliquée.")
                await self?.filterItemsByCategory(with: "Toutes catégories")
            }
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
    
    @concurrent private nonisolated func filterItemsWithSearch() async {
        let itemActor = await ItemActor(with: itemsViewModels, and: itemCategories)
        
        // Depuis une fonction nonisolated, il n'est pas possible de le faire directement depuis le MainActor. Une fois la liste filtrée récupérée, la mutation de la liste est faisable.
        let filteredItems = await itemActor.filterItemsWithSearch(query: searchQuery, activeCategory: self.activeCategory)
            
        await MainActor.run { [weak self] in
            self?.filteredItemsViewModels = filteredItems
        }
    }
    
    @concurrent private nonisolated func filterItemsByCategory(with itemCategoryName: String) async {
        let itemActor = await ItemActor(with: itemsViewModels, and: itemCategories)
        
        // Depuis une fonction nonisolated, il n'est pas possible de le faire directement depuis le MainActor. Une fois la liste filtrée récupérée, la mutation de la liste est faisable.
        let filteredItems = await itemActor.filterItemsByCategory(with: itemCategoryName, activeSearch: self.searchQuery)
        
        await MainActor.run { [weak self] in
            self?.filteredItemsViewModels = filteredItems
            self?.isLoading = false
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
            self.loadSelectedItemCategory()
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
    }
    
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
