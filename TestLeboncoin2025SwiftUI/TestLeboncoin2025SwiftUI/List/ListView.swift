//
//  ListView.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 30/06/2025.
//

import SwiftUI

struct ListView: View {
    @State var viewModel: ListViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    private var columns: [GridItem] {
        let isIpad = horizontalSizeClass == .regular
        let count = isIpad ? 4 : 2
        return Array(repeating: GridItem(.flexible(), spacing: Constants.List.spacing, alignment: .top), count: count)
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .font(.headline)
                Spacer()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: Constants.List.spacing) {
                        ForEach(viewModel.getViewModels()) { item in
                            ItemCellView(viewModel: item)
                                .onTapGesture {
                                    viewModel.coordinator?.goToDetailView(with: item)
                                }
                        }
                    }
                    .padding(Constants.List.insets)
                }
            }
        }
        .navigationTitle("Liste des articles")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.coordinator?.goToFilterView(with: viewModel.getItemCategories())
                } label: {
                    Image(systemName: "list.bullet")
                        .tint(Color(uiColor: UIColor.label))
                }
                .accessibilityIdentifier("listButton")
            }
        }
        .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Rechercher")
        .onFirstAppear {
            viewModel.fetchItemList()
        }
    }
}

#Preview {
    NavigationStack {
        let builder = ListBuilder()
        builder.buildModule(testMode: true)
        return ListView(viewModel: builder.getModule())
    }
}
