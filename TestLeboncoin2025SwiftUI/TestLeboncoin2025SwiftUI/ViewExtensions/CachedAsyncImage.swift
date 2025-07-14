//
//  CachedAsyncImage.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 12/07/2025.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: URL?
    let placeholder: String
    @State private var image: UIImage?
    @State private var isLoading: Bool = false

    static private let imageCache = NSCache<NSURL, UIImage>()

    var body: some View {
        ZStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .transition(.opacity)
            } else if isLoading {
                ProgressView()
            } else {
                Image(placeholder)
                    .resizable()
                    .scaledToFit()
            }
        }
        .task {
            guard let url else { return }
            if let cached = Self.imageCache.object(forKey: url as NSURL) {
                image = cached
                return
            }

            isLoading = true
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let downloadedImage = UIImage(data: data) else { return }
                Self.imageCache.setObject(downloadedImage, forKey: url as NSURL)
                withAnimation {
                    image = downloadedImage
                }
            } catch {
                print("❌ Erreur de téléchargement: \(error.localizedDescription)")
                image = UIImage(named: placeholder)
            }
            isLoading = false
        }
    }
}
