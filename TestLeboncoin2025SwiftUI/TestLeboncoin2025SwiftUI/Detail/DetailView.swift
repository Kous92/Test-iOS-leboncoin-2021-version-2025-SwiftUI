//
//  DetailView.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/07/2025.
//

import SwiftUI

struct DetailView: View {
    @Bindable var viewModel: DetailViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                CachedAsyncImage(url: viewModel.getImageURL(), placeholder: "leboncoinPlaceholderThumb")
                    .aspectRatio(4/3, contentMode: .fill)
                    .accessibilityIdentifier("productImage")
                    .stretchy()

                VStack(alignment: .leading, spacing: 15) {
                    Text(viewModel.itemViewModel.itemTitle)
                        .font(.scalableSystem(size: Constants.Detail.itemTitle, weight: .semibold, textStyle: .title1))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("productTitle")

                    Text(formatPriceInEuros(with: viewModel.itemViewModel.itemPrice))
                        .font(.scalableSystem(size: Constants.Detail.price, weight: .semibold, textStyle: .subheadline))
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("productPrice")

                    Text(viewModel.itemViewModel.itemAddedDate.stringToFullDateFormat())
                        .font(.scalableSystem(size: Constants.Detail.contentLabel, weight: .semibold, textStyle: .body))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("productDate")

                    if viewModel.isUrgentItem() {
                        Text("URGENT")
                            .font(.scalableSystem(size: Constants.Detail.specialLabel, weight: .semibold, textStyle: .title2))
                            .foregroundColor(.primary)
                            .padding(.vertical, 7)
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(Constants.Detail.urgentRadius)
                            .accessibilityIdentifier("urgentLabel")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 0.5)
                )

                VStack(alignment: .leading, spacing: 10) {
                    Text("Description")
                        .font(.scalableSystem(size: Constants.Detail.titleLabel, weight: .semibold, textStyle: .title3))
                        .accessibilityIdentifier("productDescriptionTitleLabel")

                    Text(viewModel.itemViewModel.itemDescription)
                        .font(.scalableSystem(size: Constants.Detail.contentLabel, weight: .medium, textStyle: .body))
                        .accessibilityIdentifier("productDescription")
                }

                if viewModel.isProfessionalSeller(), let siret = viewModel.itemViewModel.siret {
                    HStack(spacing: 15) {
                        Text("PRO")
                            .font(.scalableSystem(size: Constants.Detail.specialLabel, weight: .semibold, textStyle: .title2))
                            .foregroundColor(.white)
                            .padding(.vertical, 7)
                            .frame(minWidth: Constants.Detail.proFrame)
                            .background(Color.blue)
                            .cornerRadius(Constants.Detail.proRadius)
                            .accessibilityIdentifier("professionalSellerTitleLabel")

                        Text("N°SIRET: \(siret)")
                            .font(.system(size: Constants.Detail.contentLabel, weight: .medium))
                            .foregroundColor(.primary)
                            .accessibilityIdentifier("productPro")
                    }
                }
            }
            .padding(.horizontal, Constants.Detail.horizontalMargin)
            .padding(.top, Constants.Detail.contentViewTopMargin)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Annonce: \(viewModel.itemViewModel.itemTitle), \(viewModel.itemViewModel.itemPrice) €, publié \(viewModel.itemViewModel.itemAddedDate.stringToFullDateFormat()), \(viewModel.itemViewModel.isUrgent ? ", Urgent" : ""). Description, \(viewModel.itemViewModel.itemDescription), \(viewModel.isProfessionalSeller() ? "Vendeur professionnel" : "")")
        .navigationTitle("Détail de l’annonce")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.medium)
                }
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .tint(.primary)
        .background(Color(.systemBackground))
        .onDisappear {
            viewModel.backToPreviousScreen()
        }
    }
}

extension Font {
    static func scalableSystem(size: CGFloat, weight: UIFont.Weight = .regular, textStyle: UIFont.TextStyle = .body) -> Font {
        let uiFont = UIFont.systemFont(ofSize: size, weight: weight)
        let metrics = UIFontMetrics(forTextStyle: textStyle)
        return Font(metrics.scaledFont(for: uiFont))
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel(with: ItemViewModel.getFakeProUrgentItem()))
}
