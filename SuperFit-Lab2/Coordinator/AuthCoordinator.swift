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
        goToAuthorizationScreen()
    }
    
    func goToAuthorizationScreen() {
        let component = componentFactory.getAuthorizationComponent()
        component.authorizationViewModel.coordinator = self
        navigationController.pushViewController(component.authorizationViewController, animated: true)
    }
    
    func goToAuthorizationPinPanelScreen(email: String) {
        let component = componentFactory.getAuthorizationPinPanelComponent()
        component.authorizationPinPanelViewModel.coordinator = self
        component.authorizationPinPanelViewModel.email = email
        navigationController.pushViewController(component.authorizationPinPanelViewController, animated: true)
    }
    
    func goToRegistrationScreen() {
        let component = componentFactory.getRegistrationComponent()
        component.registrationViewModel.coordinator = self
        navigationController.pushViewController(component.registrationViewController, animated: true)
    }
    
    func goToMainScreen() {
        
    }
    
}
