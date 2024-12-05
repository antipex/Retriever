//
//  RecipeCoordinator.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import SwiftUI
import Combine
import SafariServices

final class RecipeCoordinator: Coordinator {
    private let navController: UINavigationController

    var childCoordinators: [Coordinator] = []

    private var recipeListViewModel: RecipeListViewModel?
    private var recipeDetailViewModel: RecipeDetailViewModel?

    private var cancellables = Set<AnyCancellable>()

    // MARK: Dependencies
    
    private let router: Router
    private let recipeRepository: RecipeRepositoryProtocol

    // MARK: - Init

    init(
        navController: UINavigationController,
        router: Router,
        recipeRepository: RecipeRepositoryProtocol
    ) {
        self.navController = navController
        self.router = router
        self.recipeRepository = recipeRepository
    }

    func start() {
        let viewModel = RecipeListViewModel(recipeRepository: recipeRepository)
        let viewController = BaseHostingController(rootView: RecipeListView(viewModel: viewModel))

        viewModel.coordinatorCallback.sink { [weak self] callback in
            guard let self else { return }

            switch callback {
            case .showRecipeDetail(let recipe):
                showRecipeDetail(for: recipe)
            }
        }
        .store(in: &cancellables)

        navController.pushViewController(viewController, animated: true)

        self.recipeListViewModel = viewModel
    }

    // MARK: - Navigation

    private func showRecipeDetail(for recipe: Recipe) {
        let viewModel = RecipeDetailViewModel(recipe: recipe)
        let viewController = BaseHostingController(rootView: RecipeDetailView(viewModel: viewModel))

        viewModel.coordinatorCallback.sink { [weak self] callback in
            guard let self else { return }

            switch callback {
            case .back:
                navController.popViewController(animated: true)
            case .showSafari(let url):
                showSafari(for: url)
            }
        }
        .store(in: &cancellables)

        navController.pushViewController(viewController, animated: true)

        self.recipeDetailViewModel = viewModel
    }

    private func showSafari(for url: URL) {
        Task { @MainActor in
            let viewController = SFSafariViewController(url: url)

            router.present(viewController)
        }
    }
}
