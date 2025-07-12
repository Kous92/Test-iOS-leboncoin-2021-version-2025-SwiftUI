//
//  ItemCellView.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 30/06/2025.
//

import SwiftUI

struct ItemCellView: View {
    let viewModel: ItemViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: viewModel.smallImage)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity, minHeight: 140)
                        .background(Color.gray.opacity(0.1))
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                case .failure:
                    Image("leboncoinPlaceholderSmall")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                @unknown default:
                    EmptyView()
                }
            }

            Text(viewModel.itemTitle)
                .font(.headline)
                .lineLimit(2)

            Text(formatPriceInEuros(with: viewModel.itemPrice))
                .font(.subheadline)
                .foregroundStyle(.green)
                .bold()

            Text(viewModel.itemCategory)
                .font(.caption)

            if viewModel.isUrgent {
                Text("URGENT")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(4)
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(6)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Annonce: \(viewModel.itemTitle), \(viewModel.itemPrice), \(viewModel.itemCategory)\(viewModel.isUrgent ? ", Urgent" : "")")
    }
}

#Preview("ItemCollectionViewCell preview", traits: .fixedLayout(width: 180, height: 300)) {
    ItemCellView(viewModel: ItemViewModel.getFakeItem())
}
