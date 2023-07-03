//
//  ExerciseViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import Foundation
import UIKit

final class ExerciseViewModel {

    weak var coordinator: ExercisesCoordinator?
    weak var errorHandlingDelegate: ErrorHandlingDelegate?

    private let trainingRepository: TrainingRepository
    private let exerciseManagerRepository: ExerciseRepository
    private let lastExercisesRepository: LastExercisesRepository
    private let getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase
    private let convertDateToYyyyMmDdUseCase: ConvertDateToYyyyMmDdUseCase

    var exercise: TrainingInfoModel?

    init(
        trainingRepository: TrainingRepository,
        exerciseManagerRepository: ExerciseRepository,
        lastExercisesRepository: LastExercisesRepository,
        getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase,
        convertDateToYyyyMmDdUseCase: ConvertDateToYyyyMmDdUseCase
    ) {
        self.trainingRepository = trainingRepository
        self.exerciseManagerRepository = exerciseManagerRepository
        self.lastExercisesRepository = lastExercisesRepository
        self.getTrainingTypeByTrainingInfoModelUseCase = getTrainingTypeByTrainingInfoModelUseCase
        self.convertDateToYyyyMmDdUseCase = convertDateToYyyyMmDdUseCase
    }

    func getTrainingType() -> TrainingTypeModel {
        getTrainingTypeByTrainingInfoModelUseCase.getTrainingType(
            by: exercise ?? TrainingInfoModel(
                name: "",
                description: "",
                image: UIImage()
            )
        )
    }

    func getRepsCount() -> Int {
        exerciseManagerRepository.getRepsCount(for: getTrainingType())
    }

    func saveCompletedTraining() {
        exerciseManagerRepository.saveTraining(trainingType: getTrainingType())
        lastExercisesRepository.saveLastExercise(trainingType: getTrainingType())
    }

    func saveIncomplededTraining() {
        lastExercisesRepository.saveLastExercise(trainingType: getTrainingType())
    }

}

// MARK: - Navigation
extension ExerciseViewModel {
    func goToPreviousScreen() {
        coordinator?.navigationController.popViewController(animated: true)
    }

    func goToExerciseResultScreen(result: ExerciseResult, repsLeft: Int? = nil) {
        coordinator?.goToExerciseResultScreen(
            exercise: exercise ?? TrainingInfoModel(
                name: "",
                description: "",
                image: UIImage()
            ),
            result: result,
            repsLeft: repsLeft
        )
    }

    func reauthenticateUser() {
        coordinator?.reauthenticateUser()
    }
}

// MARK: - Network requests
extension ExerciseViewModel {
    func saveTrainingResult(repsCount: Int, isCompleted: Bool) async {
        do {
            _ = try await trainingRepository.saveTraining(
                training: TrainingModel(
                    date: convertDateToYyyyMmDdUseCase.convert(Date()),
                    exercise: getTrainingType(),
                    repeatCount: repsCount
                )
            )
            if isCompleted {
                saveCompletedTraining()
            } else {
                saveIncomplededTraining()
            }
        } catch let error {
            if let appError = error as? AppError {
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            } else {
                errorHandlingDelegate?.handleErrorMessage(error.localizedDescription)
            }
        }
    }
}
