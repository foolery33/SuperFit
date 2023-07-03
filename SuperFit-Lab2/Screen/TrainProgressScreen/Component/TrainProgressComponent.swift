//
//  TrainProgressComponent.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 25.06.2023.
//

import NeedleFoundation
import UIKit

protocol TrainProgressComponentDependency: Dependency {
    var trainingRepository: TrainingRepository { get }
    var getTrainProgressByTrainingTypeModelUseCase: GetTrainProgressByTrainingTypeModelUseCase { get }
}

final class TrainProgressComponent: Component<TrainProgressComponentDependency> {
    var trainProgressViewModel: TrainProgressViewModel {
        shared {
            TrainProgressViewModel(
                trainingRepository: dependency.trainingRepository,
                getTrainProgressByTrainingTypeModelUseCase: dependency.getTrainProgressByTrainingTypeModelUseCase
            )
        }
    }

    var trainProgressViewController: TrainProgressViewController {
        return TrainProgressViewController(viewModel: trainProgressViewModel)
    }
}
