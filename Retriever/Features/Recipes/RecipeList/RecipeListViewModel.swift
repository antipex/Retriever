//
//  RecipeListViewModel.swift
//  Retriever
//
//  Created by Kyle Rohr on 3/12/2024.
//

import Foundation
import Combine

@Observable
final class RecipeListViewModel {
    @ObservationIgnored
    private let recipeRepository: RecipeRepositoryProtocol

    var state: State = .initial
    var displayables: [RecipeListItemDisplayable] = []

    @ObservationIgnored
    private var recipes: [Recipe] = []

    @ObservationIgnored
    let isDebug: Bool

    @ObservationIgnored
    let viewEvents = PassthroughSubject<ViewEvent, Never>()
    @ObservationIgnored
    let coordinatorCallback = PassthroughSubject<CoordinatorCallback, Never>()

    @ObservationIgnored
    private var cancellables = Set<AnyCancellable>()

    init(recipeRepository: RecipeRepositoryProtocol, isDebug: Bool = false) {
        self.recipeRepository = recipeRepository
        self.isDebug = isDebug

        setupBindings()
    }

    private func setupBindings() {
        viewEvents
            .sink(receiveValue: handleViewEvent)
            .store(in: &cancellables)
    }

    private func handleViewEvent(_ event: ViewEvent) {
        switch event {
        case .onAppear, .refresh:
            Task {
                await reload()
            }
        case .tappedRecipe(let displayable):
            if let recipe = recipes.first(where: { $0.id == displayable.id }) {
                coordinatorCallback.send(.showRecipeDetail(recipe))
            }
        }
    }

    func reload() async {
        guard
            !isDebug,
            state != .loading
        else { return }

        await MainActor.run {
            state = .loading
        }

        do {
            let recipes = try await recipeRepository.getRecipes()
            self.recipes = recipes
            await populateDisplayables()

            await MainActor.run {
                state = .loaded
            }
        } catch {
            await MainActor.run {
                Logger.log(level: .error, category: \.general, message: "Failed to load recipes: \(error)")

                state = .error
            }
        }
    }

    private func populateDisplayables() async {
        let displayables = recipes.map { RecipeListItemDisplayable(recipe: $0) }

        await MainActor.run {
            self.displayables = displayables
        }
    }
}

extension RecipeListViewModel {
    enum State {
        case initial
        case loading
        case loaded
        case error
    }

    enum ViewEvent {
        case onAppear
        case refresh
        case tappedRecipe(RecipeListItemDisplayable)
    }

    enum CoordinatorCallback {
        case showRecipeDetail(Recipe)
    }
}

extension RecipeListViewModel {
    static var debug: RecipeListViewModel {
        let viewModel = RecipeListViewModel(
            recipeRepository: MockRecipeRepository()
        )

        return viewModel
    }

    static var debugLoading: RecipeListViewModel {
        let viewModel = RecipeListViewModel(
            recipeRepository: MockRecipeRepository(),
            isDebug: true
        )

        viewModel.state = .loading

        return viewModel
    }

    static var debugError: RecipeListViewModel {
        let viewModel = RecipeListViewModel(
            recipeRepository: MockRecipeRepository(),
            isDebug: true
        )

        viewModel.state = .error

        return viewModel
    }

    static var debugEmpty: RecipeListViewModel {
        let viewModel = RecipeListViewModel(
            recipeRepository: MockRecipeRepository(kind: .empty)
        )

        return viewModel
    }
}
