//
//  ExercisesCoordinator.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit

final class ExercisesCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let componentFactory = ComponentFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToExercisesScreen()
    }
    
    private func goToExercisesScreen() {
        let component = componentFactory.getExercisesComponent()
        component.exercisesViewModel.coordinator = self
        navigationController.pushViewController(component.exercisesViewController, animated: true)
    }
     
}