//
//  SceneDelegate.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Logger.log(level: .info, message: "Connecting to scene...")

        guard let windowScene = scene as? UIWindowScene else {
            fatalError("Could not find windowScene!")
        }

        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()

        self.window = window
    }
}
