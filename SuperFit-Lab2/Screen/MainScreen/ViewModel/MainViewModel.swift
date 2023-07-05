//
//  MainViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import Foundation

protocol ErrorHandlingDelegate: AnyObject {
    func handleErrorMessage(_ errorMessage: String)
    func reauthorizeUser()
}

final class MainViewModel {

    weak var coordinator: MainCoordinator?
    weak var errorHandlingDelegate: ErrorHandlingDelegate?
    private let profileRepository: ProfileRepository
    private let userBodyParametersRepository: UserBodyParametersRepository
    private let trainingRepository: TrainingRepository
    private let lastExercisesRepository: LastExercisesRepository
    private let garbageManager: GarbageManager

    private let getTrainingInfoModelByTrainingTypeModelUseCase: GetTrainingInfoModelByTrainingTypeModelUseCase
    private let getTwoLastExercisesUseCase: GetTwoLastExercisesUseCase
    private let getLastBodyParametersUseCase: GetLastBodyParametersUseCase

    var lastExercises: [TrainingTypeModel] = []

    init(
        profileRepository: ProfileRepository,
        userBodyParametersRepository: UserBodyParametersRepository,
        trainingRepository: TrainingRepository,
        lastExercisesRepository: LastExercisesRepository,
        garbageManager: GarbageManager,
        getTrainingInfoModelByTrainingTypeModelUseCase: GetTrainingInfoModelByTrainingTypeModelUseCase,
        getTwoLastExercisesUseCase: GetTwoLastExercisesUseCase,
        getLastBodyParametersUseCase: GetLastBodyParametersUseCase
    ) {
        self.profileRepository = profileRepository
        self.userBodyParametersRepository = userBodyParametersRepository
        self.trainingRepository = trainingRepository
        self.lastExercisesRepository = lastExercisesRepository
        self.garbageManager = garbageManager
        self.getTrainingInfoModelByTrainingTypeModelUseCase = getTrainingInfoModelByTrainingTypeModelUseCase
        self.getTwoLastExercisesUseCase = getTwoLastExercisesUseCase
        self.getLastBodyParametersUseCase = getLastBodyParametersUseCase
    }

    func getTrainingInfoModel(from trainingTypeModel: TrainingTypeModel) -> TrainingInfoModel {
        self.getTrainingInfoModelByTrainingTypeModelUseCase.getTrainingInfo(trainingTypeModel)
    }

    func saveLastBodyParameters(from bodyParameters: [BodyParametersModel]) {
        let lastBodyParameters = getLastBodyParametersUseCase.getParameters(from: bodyParameters)
        if lastBodyParameters?.height != nil {
            userBodyParametersRepository.saveHeight(lastBodyParameters!.height)
            userBodyParametersRepository.saveWeight(lastBodyParameters!.weight)
        }
    }

    func getWeight() -> Int? {
        return userBodyParametersRepository.fetchWeight()
    }

    func getHeight() -> Int? {
        return userBodyParametersRepository.fetchHeight()
    }

}

// MARK: - Navigation
extension MainViewModel {
    func goToAuthorizationScreen() {
        garbageManager.clearAllData()
        coordinator?.goToAuthorizationScreen()
    }

    func reauthenticateUser() {
        coordinator?.reauthenticateUser()
    }

    func goToExercisesScreen() {
        coordinator?.goToExercisesScreen()
    }

    func goToMyBodyScreen() {
        coordinator?.goToMyBodyScreen()
    }

    func goToExerciseScreen(trainingInfo: TrainingInfoModel) {
        coordinator?.goToExerciseSceren(trainingInfo: trainingInfo)
    }
}

// MARK: - Network requests
extension MainViewModel {
    func getUserParameters() async -> Bool {
        guard userBodyParametersRepository.fetchHeight() == nil
                || userBodyParametersRepository.fetchWeight() == nil else { return true }
        do {
            let bodyParameters = try await profileRepository.getUserParameters()
            saveLastBodyParameters(from: bodyParameters)
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

    func getLastExercises() async -> Bool {
        do {
            if lastExercisesRepository.isThereSavedExercises() {
                let lastExercisesInMemory = lastExercisesRepository.getLastExercises()
                self.lastExercises = lastExercisesInMemory
            } else {
                let lastExercises = try await trainingRepository.getTrainingList()
                if lastExercises.count >= 2 {
                    self.lastExercises = (
                        getTwoLastExercisesUseCase.getExercises(
                            from: lastExercises
                        )
                    ).map { $0.exercise }
                } else {
                    self.lastExercises = lastExercises.map { $0.exercise }
                }
            }
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
