//
//  MainCoordinator.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let componentFactory = ComponentFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToMainScreen()
    }
    
    private func goToMainScreen() {
        let component = componentFactory.getMainScreenComponent()
        component.mainViewModel.coordinator = self
        navigationController.pushViewController(component.mainViewController, animated: true)
    }
    
    func goToExercisesScreen() {
        let exercisesCoordinator = CoordinatorFactory().createExercisesCoordinator(navigationController: self.navigationController)
        exercisesCoordinator.parentCoordinator = self
        children.append(exercisesCoordinator)
        exercisesCoordinator.start()
    }
    
}
