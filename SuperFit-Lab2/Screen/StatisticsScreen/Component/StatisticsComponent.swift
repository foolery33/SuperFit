//
//  StatisticsComponent.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 26.06.2023.
//

import NeedleFoundation
import UIKit

protocol StatisticsComponentDependency: Dependency {
    var profileRepository: ProfileRepository { get }
    var trainingRepository: TrainingRepository { get }
    var getSortedTrainingDatesUseCase: GetSortedTrainingDatesUseCase { get }
    var getSortedWeightChangesDatesUseCase: GetSortedWeightChangesDatesUseCase { get }
    var getTrainingResultsUseCase: GetTrainingResultsUseCase { get }
    var getWeightChangesUseCase: GetWeightChangesUseCase { get }
    var getNearestMultipleOfTenUseCase: GetNearestMultipleOfTenUseCase { get }
}

final class StatisticsComponent: Component<StatisticsComponentDependency> {
    var statisticsViewModel: StatisticsViewModel {
        shared {
            StatisticsViewModel(
                profileRepository: dependency.profileRepository,
                trainingRepository: dependency.trainingRepository,
                getSortedTrainingDatesUseCase: dependency.getSortedTrainingDatesUseCase,
                getSortedWeightChangesDatesUseCase: dependency.getSortedWeightChangesDatesUseCase,
                getTrainingResultsUseCase: dependency.getTrainingResultsUseCase,
                getWeightChangesUseCase: dependency.getWeightChangesUseCase,
                getNearestMultipleOfTenUseCase: dependency.getNearestMultipleOfTenUseCase
            )
        }
    }

    var statisticsViewController: StatisticsViewController {
        return StatisticsViewController(viewModel: statisticsViewModel)
    }
}
