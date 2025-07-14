//
//  DetailViewModel.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 12/07/2025.
//

import Foundation
import Observation

@Observable
final class DetailViewModel {
    weak var coordinator: DetailCoordinator?
    let itemViewModel: ItemViewModel

    init(with itemViewModel: ItemViewModel) {
        self.itemViewModel = itemViewModel
    }

    func isUrgentItem() -> Bool {
        itemViewModel.isUrgent
    }

    func isProfessionalSeller() -> Bool {
        itemViewModel.siret != nil
    }
    
    func getImageURL() -> URL? {
        return URL(string: itemViewModel.thumbImage)
    }

    func backToPreviousScreen() {
        coordinator?.backToHomeView()
    }
}
