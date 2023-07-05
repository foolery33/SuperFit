//
//  MainScreenComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import UIKit
import NeedleFoundation

protocol MainScreenComponentDependency: Dependency {
    var profileRepository: ProfileRepository { get }
    var userBodyParametersRepository: UserBodyParametersRepository { get }
    var trainingRepository: TrainingRepository { get }
    var lastExercisesRepository: LastExercisesRepository { get }
    var garbageManager: GarbageManager { get }
    var getTrainingInfoModelByTrainingTypeModelUseCase: GetTrainingInfoModelByTrainingTypeModelUseCase { get }
    var getTwoLastExercisesUseCase: GetTwoLastExercisesUseCase { get }
    var getLastBodyParametersUseCase: GetLastBodyParametersUseCase { get }
}

final class MainScreenComponent: Component<MainScreenComponentDependency> {
    var mainViewModel: MainViewModel {
        shared {
            MainViewModel(
                profileRepository: dependency.profileRepository,
                userBodyParametersRepository: dependency.userBodyParametersRepository,
                trainingRepository: dependency.trainingRepository,
                lastExercisesRepository: dependency.lastExercisesRepository,
                garbageManager: dependency.garbageManager,
                getTrainingInfoModelByTrainingTypeModelUseCase:
                    dependency.getTrainingInfoModelByTrainingTypeModelUseCase,
                getTwoLastExercisesUseCase: dependency.getTwoLastExercisesUseCase,
                getLastBodyParametersUseCase: dependency.getLastBodyParametersUseCase
            )
        }
    }

    var mainViewController: UIViewController {
        MainViewController(viewModel: mainViewModel)
    }
}
