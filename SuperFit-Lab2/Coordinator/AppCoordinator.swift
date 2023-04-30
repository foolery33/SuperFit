//
//  AppCoordinator.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToAuth()
//        if TokenManager.shared.fetchAccessToken().isEmpty {
//            goToAuth()
//        }
//        else {
//            goToMain()
//        }
    }
    
    func goToAuth() {
        let authCoordinator = CoordinatorFactory().createAuthCoordinator(navigationController: self.navigationController)
        authCoordinator.parentCoordinator = self
        children.append(authCoordinator)
        authCoordinator.start()
    }
    
    func goToMain() {
        
    }
    
}
