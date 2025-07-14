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
                ForEach(viewModel.itemCategories.indices, id: \.self) { index in
                    let item = viewModel.itemCategories[index]
                    
                    HStack {
                        Text(item.name)
                        Spacer()
                        if index == viewModel.currentSelectedIndex {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if index != viewModel.currentSelectedIndex {
                            viewModel.saveSelectedCategory(at: index)
                        }
                    }
                    .accessibilityIdentifier("category_\(index)")
                }
            }
            .navigationTitle("Catégories")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.loadSetting()
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
    let vm = FilterViewModel(itemCategories: ItemCategoryViewModel.getFakeItemCategories())
    FilterView(viewModel: vm)
}
#endif
