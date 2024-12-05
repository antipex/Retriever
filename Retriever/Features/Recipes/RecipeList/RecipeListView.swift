//
//  RecipeListView.swift
//  Retriever
//
//  Created by Kyle Rohr on 3/12/2024.
//

import SwiftUI

struct RecipeListView: View {
    var viewModel: RecipeListViewModel

    var body: some View {
        ThemedNavigationView(title: "Recipes") {
            ZStack {
                ScrollView {
                    switch viewModel.state {
                    case .loaded:
                        if viewModel.displayables.isEmpty {
                            emptyState()
                        } else {
                            loadedState()
                        }
                    case .error:
                        errorState()
                    default:
                        EmptyView()
                    }

                    if viewModel.state == .loading {
                        Spinner()
                            .padding(.top, .Spacing.eight)
                    }
                }
                .refreshable {
                    viewModel.viewEvents.send(.refresh)
                }
                .onAppear {
                    viewModel.viewEvents.send(.onAppear)
                }
            }
        }
    }

    @ViewBuilder
    private func loadedState() -> some View {
        LazyVStack(alignment: .leading) {
            ForEach(viewModel.displayables) { displayable in
                Button {
                    viewModel.viewEvents.send(.tappedRecipe(displayable))
                } label: {
                    RecipeListItem(displayable: displayable)
                }
            }
        }
        .padding(.Spacing.four)
        .padding(.bottom, .Spacing.eight)
    }

    @ViewBuilder
    private func emptyState() -> some View {
        RecipeListInfo(imageName: "rectangle.dashed", title: "No Recipes Found.")
            .padding(.top, .Spacing.eight)
    }

    @ViewBuilder
    private func errorState() -> some View {
        RecipeListInfo(imageName: "exclamationmark.triangle.fill", title: "Oops! An error has occurred.")
            .padding(.top, .Spacing.eight)
    }
}

private struct RecipeListInfo: View {
    let imageName: String
    let title: String

    var body: some View {
        VStack(spacing: .Spacing.six) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 60, maxHeight: 60)
            Text(title)
                .typography(.heading3)
        }
        .foregroundStyle(.gray)
    }
}

private struct RecipeListItem: View {
    let displayable: RecipeListItemDisplayable

    var body: some View {
        HStack(spacing: .Spacing.four) {
            CachedImage(url: displayable.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 60, maxHeight: 60)
                    .cornerRadius(.Corner.two)
            } loading: {
                Spinner()
                    .frame(maxHeight: 60)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.Spacing.four)
                    .frame(maxWidth: 60, maxHeight: 60)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(.Corner.two)
            }

            VStack(alignment: .leading) {
                Text(displayable.title)
                    .typography(.heading3)

                Text(displayable.subtitle)
                    .foregroundStyle(Color.gray)
            }

            Spacer()
        }
    }
}

#Preview("Regular") {
    RecipeListView(viewModel: .debug)
}

#Preview("Loading") {
    RecipeListView(viewModel: .debugLoading)
}

#Preview("Empty") {
    RecipeListView(viewModel: .debugEmpty)
}

#Preview("Error") {
    RecipeListView(viewModel: .debugError)
}
