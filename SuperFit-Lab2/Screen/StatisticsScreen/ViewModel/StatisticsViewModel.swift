//
//  StatisticsViewModel.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 26.06.2023.
//

import Foundation

final class StatisticsViewModel {
    
    weak var coordinator: MyBodyCoordinator?
    weak var errorHandlingDelegate: ErrorHandlingDelegate?
    
    private let profileRepository: ProfileRepository
    private let trainingRepository: TrainingRepository
    private let getSortedTrainingDatesUseCase: GetSortedTrainingDatesUseCase
    private let getSortedWeightChangesDatesUseCase: GetSortedWeightChangesDatesUseCase
    private let getTrainingResultsUseCase: GetTrainingResultsUseCase
    private let getWeightChangesUseCase: GetWeightChangesUseCase
    private let getNearestMultipleOfTenUseCase: GetNearestMultipleOfTenUseCase
    
    private(set) var bodyParameters: [BodyParametersModel] = []
    private(set) var lastExercises: [TrainingModel] = []
    
    var selectedTrainingType: TrainingTypeModel = .pushUps
    
    
    func nearestMultipleOfTen(to number: Int) -> Int {
        let roundedQuotient = Int(round(Double(number) / 10.0))
        let nearestMultiple = roundedQuotient * 10
        return nearestMultiple
    }
    
    func nearestMultipleOfTenDown(to number: Int) -> Int {
        let roundedQuotient = Int(floor(Double(number) / 10.0))
        let nearestMultiple = roundedQuotient * 10
        return nearestMultiple
    }
    
    init(
        profileRepository: ProfileRepository,
        trainingRepository: TrainingRepository,
        getSortedTrainingDatesUseCase: GetSortedTrainingDatesUseCase,
        getSortedWeightChangesDatesUseCase: GetSortedWeightChangesDatesUseCase,
        getTrainingResultsUseCase: GetTrainingResultsUseCase,
        getWeightChangesUseCase: GetWeightChangesUseCase,
        getNearestMultipleOfTenUseCase: GetNearestMultipleOfTenUseCase
    ) {
        self.profileRepository = profileRepository
        self.trainingRepository = trainingRepository
        self.getSortedTrainingDatesUseCase = getSortedTrainingDatesUseCase
        self.getSortedWeightChangesDatesUseCase = getSortedWeightChangesDatesUseCase
        self.getTrainingResultsUseCase = getTrainingResultsUseCase
        self.getWeightChangesUseCase = getWeightChangesUseCase
        self.getNearestMultipleOfTenUseCase = getNearestMultipleOfTenUseCase
    }
    
    func getSortedTrainingDates() -> [String]? {
        return getSortedTrainingDatesUseCase.getSortedDates(of: selectedTrainingType, from: lastExercises)
    }
    func getTrainingResults() -> [Int] {
        return getTrainingResultsUseCase.getTrainingResults(trainingType: selectedTrainingType, from: lastExercises)
    }
    
    
    func getWeightChanges() -> [Int] {
        return getWeightChangesUseCase.getChanges(bodyParameters: bodyParameters)
    }
    func getSortedWeightChanges() -> [String]? {
        return getSortedWeightChangesDatesUseCase.getSortedDates(from: bodyParameters)
    }
    
    func getNearestMultipleOfTen(number: Int, toTop: Bool) -> Int {
        return getNearestMultipleOfTenUseCase.getNearest(number: number, toTop: toTop)
    }
    
}

// MARK: - Navigation
extension StatisticsViewModel {
    func goBackToMyBodyScreen() {
        coordinator?.navigationController.popViewController(animated: true)
    }
}

// MARK: - Network requests
extension StatisticsViewModel {
    func getUserParameters() async -> Bool {
        do {
            self.bodyParameters = try await profileRepository.getUserParameters()
            return true
        } catch(let error) {
            if let appError = error as? AppError {
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            }
            else {
                errorHandlingDelegate?.handleErrorMessage(error.localizedDescription)
            }
            return false
        }
    }
    func getLastExercises() async -> Bool {
        do {
            let lastExercises = try await trainingRepository.getTrainingList()
            self.lastExercises = lastExercises
            return true
        } catch(let error) {
            if let appError = error as? AppError {
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            }
            else {
                errorHandlingDelegate?.handleErrorMessage(error.localizedDescription)
            }
            return false
        }
    }
}
