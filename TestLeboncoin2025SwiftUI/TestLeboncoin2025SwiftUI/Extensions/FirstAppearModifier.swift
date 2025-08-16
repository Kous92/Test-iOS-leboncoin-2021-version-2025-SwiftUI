//
//  FirstAppearModifier.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 13/08/2025.
//

import Foundation
import SwiftUI

/// Cette modification de vue assure que le contenu d'initialisation ne se déclenche qu'une seule fois
public struct FirstAppearModifier: ViewModifier {
    
    private let action: () async -> Void
    @State private var hasAppeared = false
    
    public init(_ action: @escaping () async -> Void) {
        self.action = action
    }
    
    // Ici dans le cadre d'un onAppear, en mode asynchrone.
    public func body(content: Content) -> some View {
        content.task {
            guard !hasAppeared else { return }
            hasAppeared = true
            await action()
        }
    }
}

// Il faut que cette modification de vue soit disponible pour n'importe quelle vue.
public extension View {
    func onFirstAppear(_ action: @escaping () async -> Void) -> some View {
        modifier(FirstAppearModifier(action))
    }
}
