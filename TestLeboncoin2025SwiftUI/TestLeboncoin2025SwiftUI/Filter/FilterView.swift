//
//  FilterView.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/07/2025.
//

import SwiftUI

struct FilterView: View {
    @Bindable var viewModel: FilterViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.itemCategories, id: \.self) { itemCategory in
                    HStack {
                        Text(itemCategory.name)
                        Spacer()
                        if itemCategory.id == viewModel.currentSelectedIndex {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if itemCategory.id != viewModel.currentSelectedIndex {
                            viewModel.saveSelectedCategory(at: itemCategory.id)
                        }
                    }
                    .accessibilityIdentifier("category_\(itemCategory.id)")
                }
            }
            .navigationTitle("Catégories")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.loadSetting()
            }
            .onDisappear {
                viewModel.backToPreviousScreen()
            }
        }
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("FilterView") {
    let builder = FilterBuilder(with: ItemCategoryViewModel.getFakeItemCategories())
    builder.buildModule(testMode: true)
    return FilterView(viewModel: builder.getModule())
}
#endif
