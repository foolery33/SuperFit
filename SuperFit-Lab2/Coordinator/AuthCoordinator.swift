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
    
    private let authorizationComponent = ComponentFactory().getAuthorizationComponent()
    private let authorizationPinPanelComponent = ComponentFactory().getAuthorizationPinPanelComponent()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToAuthorizationScreen()
    }
    
    func goToAuthorizationScreen() {
        let component = self.authorizationComponent
        component.authorizationViewModel.coordinator = self
        navigationController.pushViewController(component.authorizationViewController, animated: true)
    }
    
    func goToAuthorizationPinPanelScreen(userName: String) {
        let component = self.authorizationPinPanelComponent
        component.authorizationPinPanelViewModel.coordinator = self
        component.authorizationPinPanelViewModel.userName = userName
        navigationController.pushViewController(component.authorizationPinPanelViewController, animated: true)
    }
    
    func goToRegisterScreen() {
        
    }
    
    func goToMainScreen() {
        
    }
    
}
