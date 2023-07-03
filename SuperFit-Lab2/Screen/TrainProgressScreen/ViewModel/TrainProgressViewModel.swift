//
//  TrainProgressViewModel.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 25.06.2023.
//

import Foundation

final class TrainProgressViewModel {

    weak var coordinator: MyBodyCoordinator?
    weak var errorHandlingDelegate: ErrorHandlingDelegate?

    private let trainingRepository: TrainingRepository
    private let getTrainProgressByTrainingTypeModelUseCase: GetTrainProgressByTrainingTypeModelUseCase

    var trainingList: [TrainingModel] = []

    init(
        trainingRepository: TrainingRepository,
        getTrainProgressByTrainingTypeModelUseCase: GetTrainProgressByTrainingTypeModelUseCase
    ) {
        self.trainingRepository = trainingRepository
        self.getTrainProgressByTrainingTypeModelUseCase = getTrainProgressByTrainingTypeModelUseCase
    }

    func getTrainProgressByTrainingTypeModel(_ trainingType: TrainingTypeModel) -> TrainingProgressModel? {
        getTrainProgressByTrainingTypeModelUseCase.calculateTrainingProgress(
            trainingType: trainingType,
            trainingList: trainingList
        )
    }

}

// MARK: - Navigation
extension TrainProgressViewModel {
    func goToPreviousScreen() {
        coordinator?.navigationController.popViewController(animated: true)
    }
    func reauthenticateUser() {
        coordinator?.reauthenticateUser()
    }
}

// MARK: - Network requests
extension TrainProgressViewModel {
    func getTrainingList() async -> Bool {
        do {
            trainingList = try await trainingRepository.getTrainingList()
            return true
        } catch let error {
            if let appError = error as? AppError {
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            } else {
                errorHandlingDelegate?.handleErrorMessage(error.localizedDescription)
            }
            return false
        }
    }
}
