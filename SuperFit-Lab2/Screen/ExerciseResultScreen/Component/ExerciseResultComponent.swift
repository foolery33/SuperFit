//
//  ExerciseResultComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit
import NeedleFoundation

protocol ExerciseResultComponentDependency: Dependency {
    var getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase { get }
    var getFailurePhraseUseCase: GetFailurePhraseUseCase { get }
}

final class ExerciseResultComponent: Component<ExerciseResultComponentDependency> {
    var exerciseResultViewModel: ExerciseResultViewModel {
        shared {
            ExerciseResultViewModel(
                getTrainingTypeByTrainingInfoModelUseCase: dependency.getTrainingTypeByTrainingInfoModelUseCase,
                getFailurePhraseUseCase: dependency.getFailurePhraseUseCase
            )
        }
    }
    
    var exerciseResultViewController: UIViewController {
        ExerciseResultViewController(viewModel: exerciseResultViewModel)
    }
}
