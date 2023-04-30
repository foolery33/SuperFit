//
//  AuthCoordinator.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit

class AuthCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let componentFactory = ComponentFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToLoginScreen()
    }
    
    func goToLoginScreen() {
        let component = self.componentFactory.getAuthorizationComponent()
        component.authorizationViewModel.coordinator = self
        navigationController.pushViewController(component.authorizationViewController, animated: true)
    }
    
    func goToRegisterScreen() {
        
    }
    
    func goToMainScreen() {
        
    }
    
}
