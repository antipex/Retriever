//
//  RecipeDetailView.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import SwiftUI

struct RecipeDetailView: View {
    var viewModel: RecipeDetailViewModel
    
    var body: some View {
        ThemedNavigationView
            .withBackButton(title: viewModel.displayable.title, action: {
                viewModel.viewEvents.send(.tappedBack)
            }, content: {
                ZStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        CachedImage(url: viewModel.displayable.imageUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } loading: {
                            Spinner()
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }

                        VStack(alignment: .leading) {
                            Text(viewModel.displayable.title)
                                .typography(.heading1)

                            HStack(spacing: .Spacing.two) {
                                Image(systemName: "globe")
                                Text(viewModel.displayable.subtitle)
                                    .typography(.bodyXL)
                            }
                            .foregroundStyle(.gray)

                            ThemedDivider(color: .gray.opacity(0.3))
                                .padding(.vertical, .Spacing.three)

                            HStack {
                                if let learnMoreUrl = viewModel.displayable.learnMoreUrl {
                                    RecipeDetailActionButton(title: "Learn More", action: {
                                        viewModel.viewEvents.send(.tappedAction(learnMoreUrl))
                                    })
                                }
                                if let youtubeUrl = viewModel.displayable.youtubeUrl {
                                    RecipeDetailActionButton(imageName: "video.fill", action: {
                                        viewModel.viewEvents.send(.tappedAction(youtubeUrl))
                                    })
                                }
                            }
                        }
                        .padding(.horizontal, .Spacing.four)

                        Spacer()
                    }
                }
            })
    }
}

private struct RecipeDetailActionButton: View {
    let title: String?
    let imageName: String?
    let action: () -> Void

    init(title: String? = nil, imageName: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.imageName = imageName
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Group {
                if let title {
                    Text(title)
                        .typography(.heading3)
                        .padding(.horizontal, .Spacing.six)
                } else if let imageName {
                    Image(systemName: imageName)
                        .padding(.horizontal, .Spacing.four)
                }
            }
            .frame(maxHeight: 32)
            .padding(.vertical, .Spacing.three)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(.Corner.infinity)
            .foregroundStyle(Color.primary)
        }
    }
}

#Preview {
    RecipeDetailView(viewModel: .debug)
}
