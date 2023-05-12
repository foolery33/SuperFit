//
//  ExerciseComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import NeedleFoundation
import UIKit

protocol ExerciseComponentDependency: Dependency {
    var getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase { get }
}

final class ExerciseComponent: Component<ExerciseComponentDependency> {
    var exerciseViewModel: ExerciseViewModel {
        shared {
            ExerciseViewModel(
                getTrainingTypeByTrainingInfoModelUseCase: dependency.getTrainingTypeByTrainingInfoModelUseCase
            )
        }
    }
    
    var exerciseViewController: UIViewController {
        return ExerciseViewController(viewModel: exerciseViewModel)
    }
}
