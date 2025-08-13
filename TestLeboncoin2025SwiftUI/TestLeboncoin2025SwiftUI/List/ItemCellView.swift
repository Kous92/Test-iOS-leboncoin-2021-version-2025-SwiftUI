//
//  ItemCellView.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 30/06/2025.
//

import SwiftUI

struct ItemCellView: View {
    let viewModel: ItemViewModel
    // let cellWidth: CGFloat
    
    var body: some View {
        // let imageHeight = cellWidth * 0.75 // ratio 3:4
        VStack(alignment: .leading, spacing: 8) {
            /*
            CachedAsyncImage(url: URL(string: viewModel.smallImage), placeholder: "leboncoinPlaceholderSmall")
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.red)
                        .aspectRatio(4/3, contentMode: .fit)
                        // .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                )
             */
            /*
            AsyncImage(url: URL(string: viewModel.smallImage) ?? URL(string: "leboncoinPlaceholderSmall")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .aspectRatio(4/3, contentMode: .fit)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .aspectRatio(4/3, contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                        
                    case .failure:
                        Image("leboncoinPlaceholderSmall")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .aspectRatio(4/3, contentMode: .fit)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            */
            
            /*
            RoundedRectangle(cornerRadius: 10)
                .stroke(.red)
                .aspectRatio(4/3, contentMode: .fit)
             */
            /*
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2)) // couleur de fond si pas d'image
                    .aspectRatio(4/3, contentMode: .fit)
                
                AsyncImage(url: URL(string: viewModel.smallImage) ?? URL(string: "leboncoinPlaceholderSmall")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .padding(20)
                            .foregroundColor(.gray)
                        
                    @unknown default:
                        EmptyView()
                    }
                }
                .aspectRatio(4/3, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
             */
            CachedAsyncImage(url: URL(string: viewModel.smallImage), placeholder: "leboncoinPlaceholderSmall")
                .aspectRatio(4/3, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(viewModel.itemTitle)
                .font(.headline)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
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

/*
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
 */
/*
 CachedAsyncImage(url: URL(string: viewModel.smallImage), placeholder: "leboncoinPlaceholderSmall")
 .frame(maxWidth: .infinity) // S'assurer que l'image prend toute la largeur disponible
 .aspectRatio(4/3, contentMode: .fit) // Définir un aspect ratio fixe pour l'image
 .cornerRadius(10)
 .background(Color.gray.opacity(0.1)) // Couleur de fond pour le placeholder/chargement
 .clipped()
 */

/*
 CachedAsyncImage(url: URL(string: viewModel.smallImage), placeholder: "leboncoinPlaceholderSmall")
 .frame(width: 150, height: 150, alignment: .center)
 */
// .scaledToFill()
/*
 .containerRelativeFrame([.vertical, .horizontal]) { size, axis in
 print("Size: \(size), Axis: \(axis)")
 return axis == .horizontal ? proxy.size.width : proxy.size.width * 0.75
 }
 */
// .aspectRatio(4 / 3, contentMode: .fit)
/*
 .cornerRadius(10)
 .background(RoundedRectangle(cornerRadius: 8)
 .stroke(Color.blue, lineWidth: 1)
 .background(Color(.systemBackground)))
 .mask(
 RoundedRectangle(cornerRadius: 8)
 .stroke(Color.red)
 .frame(width: 150, height: proxy.size.width * 0.75)
 )
 */
