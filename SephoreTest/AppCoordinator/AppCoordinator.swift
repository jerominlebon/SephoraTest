//
//  AppCoordinator.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let listViewController = ListViewController()
        listViewController.coordinator = self
        navigationController.pushViewController(listViewController, animated: false)
    }
}
