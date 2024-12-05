//
//  RecipeDetailViewModel.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import Foundation
import Combine

@Observable
final class RecipeDetailViewModel {
    private let recipe: Recipe
    let displayable: RecipeDetailDisplayable

    @ObservationIgnored
    let viewEvents = PassthroughSubject<ViewEvent, Never>()
    @ObservationIgnored
    let coordinatorCallback = PassthroughSubject<CoordinatorCallback, Never>()

    @ObservationIgnored
    private var cancellables = Set<AnyCancellable>()

    init(recipe: Recipe) {
        self.recipe = recipe
        self.displayable = RecipeDetailDisplayable(recipe: recipe)

        setupBindings()
    }

    private func setupBindings() {
        viewEvents
            .sink(receiveValue: handleViewEvent)
            .store(in: &cancellables)
    }

    private func handleViewEvent(_ event: ViewEvent) {
        switch event {
        case .tappedAction(let url):
            coordinatorCallback.send(.showSafari(url))
        case .tappedBack:
            coordinatorCallback.send(.back)
        }
    }
}

extension RecipeDetailViewModel {
    enum ViewEvent {
        case tappedAction(URL)
        case tappedBack
    }

    enum CoordinatorCallback {
        case back
        case showSafari(URL)
    }
}

extension RecipeDetailViewModel {
    static var debug: RecipeDetailViewModel {
        guard let recipe = DebugLoader().load(Recipe.self, fromFileNamed: "bakewellTart") else {
            fatalError("Could not load debug recipe.")
        }

        return RecipeDetailViewModel(recipe: recipe)
    }
}
