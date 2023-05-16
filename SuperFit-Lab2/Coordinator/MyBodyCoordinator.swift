//
//  MyBodyCoordinator.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit

final class MyBodyCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let componentFactory = ComponentFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToMyBodyScreen()
    }
    
    private func goToMyBodyScreen() {
        let component = componentFactory.getMyBodyComponent()
        component.myBodyViewModel.coordinator = self
        navigationController.pushViewController(component.myBodyViewController, animated: true)
    }
    
    
}
