//
//  CachedImage.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import SwiftUI

struct CachedImage<Content: View, Loading: View, Placeholder: View>: View {
    let url: URL
    let content: (Image) -> Content
    let loading: (() -> Loading)?
    let placeholder: () -> Placeholder

    @State private var isLoading: Bool = false

    init(
        url: URL,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder loading: @escaping () -> Loading,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.content = content
        self.loading = loading
        self.placeholder = placeholder
    }

    @State private var image: Image? = nil

    var body: some View {
        ZStack {
            if let image {
                content(image)
            } else {
                if isLoading {
                    if let loading {
                        loading()
                    }
                } else {
                    placeholder()
                }
            }
        }
        .task { await load() }
    }

    private func load() async {
        guard !isLoading else { return }

        isLoading = true

        let request = URLRequest(url: url)

        if
            let cachedResponse = URLCache.shared.cachedResponse(for: request),
            let cachedImage = UIImage(data: cachedResponse.data)
        {
            await MainActor.run {
                image = Image(uiImage: cachedImage)
                isLoading = false
            }
        } else {
            do {
                let (data, response) = try await URLSession.shared.data(for: request)

                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: request)

                if let uiImage = UIImage(data: data) {
                    await MainActor.run {
                        image = Image(uiImage: uiImage)
                        isLoading = false
                    }
                } else {
                    await MainActor.run {
                        isLoading = false
                    }
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    CachedImage(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f21f80c8-890a-46c5-8d1e-28baf52c30c8/small.jpg")!) { image in
        image.resizable()
    } loading: {
        Spinner()
    } placeholder: {
        Image(systemName: "photo")
    }
}
