//
//  SceneDelegate.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let navController = UINavigationController()
            coordinator = AppCoordinator(navigationController: navController)
            coordinator?.start()

            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = navController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

