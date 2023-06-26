//
//  ExerciseComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import NeedleFoundation
import UIKit

protocol ExerciseComponentDependency: Dependency {
    var trainingRepository: TrainingRepository { get }
    var exerciseManagerRepository: ExerciseRepository { get }
    var lastExercisesRepository: LastExercisesRepository { get }
    var getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase { get }
    var convertDateToYyyyMmDdUseCase: ConvertDateToYyyyMmDdUseCase { get }
}

final class ExerciseComponent: Component<ExerciseComponentDependency> {
    var exerciseViewModel: ExerciseViewModel {
        shared {
            ExerciseViewModel(
                trainingRepository: dependency.trainingRepository,
                exerciseManagerRepository: dependency.exerciseManagerRepository,
                lastExercisesRepository: dependency.lastExercisesRepository,
                getTrainingTypeByTrainingInfoModelUseCase: dependency.getTrainingTypeByTrainingInfoModelUseCase,
                convertDateToYyyyMmDdUseCase: dependency.convertDateToYyyyMmDdUseCase
            )
        }
    }
    
    var exerciseViewController: UIViewController {
        return ExerciseViewController(viewModel: exerciseViewModel)
    }
}
