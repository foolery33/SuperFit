//
//  ExercisesViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import Foundation

final class ExercisesViewModel {

    weak var coordinator: ExercisesCoordinator?

    var exercises: [TrainingInfoModel] = [
        TrainingInfoModel(
            name: R.string.mainScreenStrings.push_ups(),
            description: R.string.mainScreenStrings.push_ups_description(),
            image: R.image.pushUps()!
        ),
        TrainingInfoModel(
            name: R.string.mainScreenStrings.plank(),
            description: R.string.mainScreenStrings.plank_description(),
            image: R.image.plank()!
        ),
        TrainingInfoModel(
            name: R.string.mainScreenStrings.squats(),
            description: R.string.mainScreenStrings.squats_description(),
            image: R.image.squats()!
        ),
        TrainingInfoModel(
            name: R.string.mainScreenStrings.crunch(),
            description: R.string.mainScreenStrings.crunch_description(),
            image: R.image.crunch()!
        ),
        TrainingInfoModel(
            name: R.string.mainScreenStrings.running(),
            description: R.string.mainScreenStrings.running_description(),
            image: R.image.running()!
        )
    ]

}

// MARK: - Navigation
extension ExercisesViewModel {
    func goToPreviousScreen() {
        coordinator?.navigationController.popViewController(animated: true)
    }

    func goToExerciseScreen(exercise: TrainingInfoModel) {
        coordinator?.goToExerciseScreen(exercise: exercise)
    }
}
