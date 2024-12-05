//
//  AppCoordinator.swift
//  Retriever
//
//  Created by Kyle Rohr on 3/12/2024.
//

import SwiftUI
import Combine

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    lazy private(set) var navController: UINavigationController = UINavigationController()

    private var cancellables = Set<AnyCancellable>()

    // MARK: Dependencies

    private let router: Router
    private let recipeRepository: RecipeRepository

    // MARK: - Init

    init() {
        Logger.log(level: .info, category: \.appCoordinator, message: "Initialising AppCoordinator")

        router = Router()
        recipeRepository = RecipeRepository()
    }

    func start() {
        Task { @MainActor in
            router.reset(to: navController, animated: false)
        }

        startRecipeCoordinator()
    }

    // MARK: - Navigation

    private func startRecipeCoordinator() {
        let coordinator = RecipeCoordinator(
            navController: navController,
            router: router,
            recipeRepository: recipeRepository
        )

        addChild(coordinator)

        coordinator.start()
    }
}
