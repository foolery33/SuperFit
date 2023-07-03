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
        let exercisesCoordinator = CoordinatorFactory().createExercisesCoordinator(
            navigationController: navigationController
        )
        exercisesCoordinator.parentCoordinator = self
        children.append(exercisesCoordinator)
        exercisesCoordinator.start()
    }

    func goToMyBodyScreen() {
        let myBodyCoordinator = CoordinatorFactory().createMyBodyCoordinator(navigationController: navigationController)
        myBodyCoordinator.parentCoordinator = self
        children.append(myBodyCoordinator)
        myBodyCoordinator.start()
    }

    func goToAuthorizationScreen() {
        GarbageManager.shared.clearAllData()
        if let appCoordinator = parentCoordinator as? AppCoordinator {
            appCoordinator.goToAuth()
            parentCoordinator?.childDidFinish(self)
        }
    }

    func goToExerciseSceren(trainingInfo: TrainingInfoModel) {
        let myExerciseCoordinator = CoordinatorFactory().createExercisesCoordinator(
            navigationController: navigationController
        )
        myExerciseCoordinator.parentCoordinator = self
        children.append(myExerciseCoordinator)
        myExerciseCoordinator.start(trainingInfo: trainingInfo)
    }

    func reauthenticateUser() {
        goToAuthorizationScreen()
    }

}
