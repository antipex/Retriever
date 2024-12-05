//
//  AppDelegate.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    private(set) var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        Logger.log(level: .info, message: "App finished launching...")

        appCoordinator = AppCoordinator()
        appCoordinator?.start()

        return true
    }
}
