//
//  ExercisesCoordinator.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit

protocol ExerciseProtocol: AnyObject {
    func goToExerciseScreen(exercise: TrainingInfoModel)
}

final class ExercisesCoordinator: Coordinator, ExerciseProtocol {

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
    func start(trainingInfo: TrainingInfoModel) {
        goToExerciseScreen(exercise: trainingInfo)
    }

    private func goToExercisesScreen() {
        let component = componentFactory.getExercisesComponent()
        component.exercisesViewModel.coordinator = self
        navigationController.pushViewController(component.exercisesViewController, animated: true)
    }

    func goToExerciseScreen(exercise: TrainingInfoModel) {
        let component = componentFactory.getExerciseComponent()
        component.exerciseViewModel.coordinator = self
        component.exerciseViewModel.exercise = exercise
        navigationController.pushViewController(component.exerciseViewController, animated: true)
    }

    func goToExerciseResultScreen(exercise: TrainingInfoModel, result: ExerciseResult, repsLeft: Int? = nil) {
        let component = componentFactory.getExerciseResultComponent()
        component.exerciseResultViewModel.coordinator = self
        component.exerciseResultViewModel.exercise = exercise
        component.exerciseResultViewModel.exerciseResult = result
        component.exerciseResultViewModel.repsLeft = repsLeft
        navigationController.pushViewController(component.exerciseResultViewController, animated: true)
    }

    func reauthenticateUser() {
        UserDataManagerRepositoryImplementation().clearAllData()
        parentCoordinator?.childDidFinish(self)
        let authorizationComponent = componentFactory.getAuthorizationComponent()
        navigationController.pushViewController(authorizationComponent.authorizationViewController, animated: false)
    }

    func goToMainScreen() {
        parentCoordinator?.childDidFinish(self)
        if let mainViewController = self.navigationController.viewControllers.first(
            where: { $0 is MainViewController }
        ) {
            self.navigationController.popToViewController(mainViewController, animated: true)
        }
    }

}
