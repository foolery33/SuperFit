//
//  CoordinatorFactory.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit

final class CoordinatorFactory {
    func createAppCoordinator(navigationController: UINavigationController) -> AppCoordinator {
        return AppCoordinator(navigationController: navigationController)
    }
    func createAuthCoordinator(navigationController: UINavigationController) -> AuthCoordinator {
        return AuthCoordinator(navigationController: navigationController)
    }
    func createMainCoordinator(navigationController: UINavigationController) -> MainCoordinator {
        return MainCoordinator(navigationController: navigationController)
    }
    func createExercisesCoordinator(navigationController: UINavigationController) -> ExercisesCoordinator {
        return ExercisesCoordinator(navigationController: navigationController)
    }
    func createMyBodyCoordinator(navigationController: UINavigationController) -> MyBodyCoordinator {
        return MyBodyCoordinator(navigationController: navigationController)
    }
}
