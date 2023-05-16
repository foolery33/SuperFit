//
//  MainViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import Foundation

final class MainViewModel {
    
    weak var coordinator: MainCoordinator?
    private var model = MainModel()
    private var trainingRepository: TrainingRepository
    private var getTrainingInfoModelByTrainingTypeModelUseCase: GetTrainingInfoModelByTrainingTypeModelUseCase
    
    init(trainingRepository: TrainingRepository, getTrainingInfoModelByTrainingTypeModelUseCase: GetTrainingInfoModelByTrainingTypeModelUseCase) {
        self.trainingRepository = trainingRepository
        self.getTrainingInfoModelByTrainingTypeModelUseCase = getTrainingInfoModelByTrainingTypeModelUseCase
    }
    
    var lastExercises: [TrainingModel] {
        get {
            model.lastExercises
        }
        set {
            model.lastExercises = newValue
        }
    }
    
    var error: String = ""
    
    func getTrainingInfoModel(from trainingTypeModel: TrainingTypeModel) -> TrainingInfoModel {
        self.getTrainingInfoModelByTrainingTypeModelUseCase.getTrainingInfo(trainingTypeModel)
    }
    
    func goToExercisesScreen() {
        coordinator?.goToExercisesScreen()
    }
    
    func goToMyBodyScreen() {
        coordinator?.goToMyBodyScreen()
    }
    
    func getLastExercises() async -> Bool {
        do {
            self.lastExercises = try await trainingRepository.getTrainingList()
            return true
        } catch(let error) {
            if let appErrpr = error as? AppError {
                self.error = appErrpr.errorDescription
            }
            else {
                self.error = error.localizedDescription
            }
            return false
        }
        
    }
    
//    func getLastExercises(completion: @escaping (Bool) -> Void) {
//        trainingRepository.getTrainingList { [weak self] result in
//            switch result {
//            case .success(let data):
//                self?.lastExercises = self?.model.getTwoLastExercises(exercises: data) ?? []
//                completion(true)
//            case .failure(let error):
//                self?.error = error.errorDescription
//                completion(false)
//            }
//        }
//    }
    
}
