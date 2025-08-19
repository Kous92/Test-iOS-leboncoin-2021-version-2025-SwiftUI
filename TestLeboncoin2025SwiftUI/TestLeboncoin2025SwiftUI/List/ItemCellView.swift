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
            CachedAsyncImage(url: URL(string: viewModel.smallImage), placeholder: "leboncoinPlaceholderSmall")
                .aspectRatio(4/3, contentMode: .fit)
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(uiColor: UIColor.label), lineWidth: 0.5))
                .shadow(color: Color(uiColor: UIColor.label).opacity(0.4), radius: 3, x: 0, y: 0)
            
            Text(viewModel.itemTitle)
                .font(.headline)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(formatPriceInEuros(with: viewModel.itemPrice))
                .font(.system(.subheadline))
                .foregroundStyle(.green)
                .bold()
            
            Text(viewModel.itemCategory)
                .font(.system(.caption))
            
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
                .shadow(color: Color(uiColor: UIColor.label).opacity(0.3), radius: 2, x: 0, y: 0)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Annonce: \(viewModel.itemTitle), \(viewModel.itemPrice), \(viewModel.itemCategory)\(viewModel.isUrgent ? ", Urgent" : "")")
        
    }
}

#Preview("ItemCollectionViewCell preview", traits: .fixedLayout(width: 180, height: 300)) {
    ItemCellView(viewModel: ItemViewModel.getFakeItem())
}
