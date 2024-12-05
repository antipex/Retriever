//
//  Router.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import SwiftUI

actor Router {
    @MainActor
    private var window: UIWindow? {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow })
    }

    // MARK: - Routing

    @MainActor
    func route(to destination: Destination) async {
        switch destination {
        case .recipeList:
            break
        case .recipeDetail(let recipe):
            break
        }
    }

    @MainActor
    func reset(to viewController: UIViewController, animated: Bool = true) {
        guard let window else {
            Logger.log(level: .error, category: \.router, message: "No window found while trying to route to \(viewController)")
            return
        }

        window.rootViewController = viewController

        if animated {
            UIView.transition(
                with: window,
                duration: 0.25,
                options: .transitionCrossDissolve,
                animations: nil,
                completion: nil
            )
        }
    }

    @MainActor
    func present(_ viewController: UIViewController, animated: Bool = true) {
        guard
            let window
        else {
            Logger.log(level: .error, category: \.router, message: "No window found while trying to present \(viewController)")
            return
        }

        window.visibleViewController?.present(viewController, animated: animated)
    }

    @MainActor
    func openUrl(_ url: URL) async {
        await UIApplication.shared.open(url)
    }
}

extension Router {
    enum Destination {
        case recipeList
        case recipeDetail(recipe: Recipe)
    }
}
