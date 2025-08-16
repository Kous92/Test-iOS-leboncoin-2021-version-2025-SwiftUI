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
                        .font(.system(size: Constants.Detail.itemTitle, weight: .semibold))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("productTitle")

                    Text(formatPriceInEuros(with: viewModel.itemViewModel.itemPrice))
                        .font(.system(size: Constants.Detail.price, weight: .semibold))
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("productPrice")

                    Text(viewModel.itemViewModel.itemAddedDate.stringToFullDateFormat())
                        .font(.system(size: Constants.Detail.contentLabel, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("productDate")

                    if viewModel.isUrgentItem() {
                        Text("URGENT")
                            .font(.system(size: Constants.Detail.specialLabel, weight: .semibold))
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
                        .font(.system(size: Constants.Detail.titleLabel, weight: .semibold))
                        .accessibilityIdentifier("productDescriptionTitleLabel")

                    Text(viewModel.itemViewModel.itemDescription)
                        .font(.system(size: Constants.Detail.contentLabel, weight: .medium))
                        .accessibilityIdentifier("productDescription")
                }

                if viewModel.isProfessionalSeller(), let siret = viewModel.itemViewModel.siret {
                    HStack(spacing: 15) {
                        Text("PRO")
                            .font(.system(size: Constants.Detail.specialLabel, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 7)
                            .frame(minWidth: 44)
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
#Preview {
    DetailView(viewModel: DetailViewModel(with: ItemViewModel.getFakeProUrgentItem()))
}
