//
//  DetailCoordinator.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/07/2025.
//

import SwiftUI

final class DetailCoordinator: Coordinator {
    var path = [AppRoute]()
    
    @ViewBuilder func start() -> some View {
        DetailView()
    }
}
