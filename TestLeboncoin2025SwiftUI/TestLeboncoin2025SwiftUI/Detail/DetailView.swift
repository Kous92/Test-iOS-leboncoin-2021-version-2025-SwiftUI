//
//  DetailView.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/07/2025.
//

import SwiftUI

struct DetailView: View {
    @Bindable var viewModel: DetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                CachedAsyncImage(url: viewModel.getImageURL(), placeholder: "leboncoinPlaceholderThumb")
                    .aspectRatio(4/3, contentMode: .fit)
                    .accessibilityIdentifier("productImage")

                VStack(alignment: .leading, spacing: 15) {
                    Text(viewModel.itemViewModel.itemTitle)
                        .font(.system(size: Constants.Detail.itemTitle, weight: .semibold))
                        .foregroundColor(.primary)
                        .accessibilityIdentifier("productTitle")

                    Text(formatPriceInEuros(with: viewModel.itemViewModel.itemPrice))
                        .font(.system(size: Constants.Detail.price, weight: .semibold))
                        .foregroundColor(.green)
                        .accessibilityIdentifier("productPrice")

                    Text(viewModel.itemViewModel.itemAddedDate.stringToFullDateFormat())
                        .font(.system(size: Constants.Detail.contentLabel, weight: .semibold))
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
                .background(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
                    .background(Color(.systemBackground)))

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
        /*
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("List") {
                    viewModel.backToPreviousScreen()
                }
                .accessibilityIdentifier("listButton")
            }
        }
        */
        .background(Color(.systemBackground))
        .onAppear {
            // viewModel.loadData()
        }
        .onDisappear {
            viewModel.backToPreviousScreen()
        }
    }
}
#Preview {
    DetailView(viewModel: DetailViewModel(with: ItemViewModel.getFakeProUrgentItem()))
}
