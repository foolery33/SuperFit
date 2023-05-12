//
//  MainScreenComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import UIKit
import NeedleFoundation

protocol MainScreenComponentDependency: Dependency {
    var trainingRepository: TrainingRepository { get }
    var getTrainingInfoModelByTrainingTypeModelUseCase: GetTrainingInfoModelByTrainingTypeModelUseCase { get }
}

final class MainScreenComponent: Component<MainScreenComponentDependency> {
    var mainViewModel: MainViewModel {
        shared {
            MainViewModel(
                trainingRepository: dependency.trainingRepository,
                getTrainingInfoModelByTrainingTypeModelUseCase: dependency.getTrainingInfoModelByTrainingTypeModelUseCase
            )
        }
    }
    
    var mainViewController: UIViewController {
        MainViewController(viewModel: mainViewModel)
    }
}
