//
//  ExerciseResultViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit

final class ExerciseResultViewModel {
    
    weak var coordinator: ExercisesCoordinator?
    
    private let getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase
    private let getFailurePhraseUseCase: GetFailurePhraseUseCase
    
    var exerciseResult: ExerciseResult?
    var repsLeft: Int?
    var exercise: TrainingInfoModel?
    
    init(
        getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase,
        getFailurePhraseUseCase: GetFailurePhraseUseCase
    ) {
        self.getTrainingTypeByTrainingInfoModelUseCase = getTrainingTypeByTrainingInfoModelUseCase
        self.getFailurePhraseUseCase = getFailurePhraseUseCase
    }
    
    func getTrainingType() -> TrainingTypeModel {
        getTrainingTypeByTrainingInfoModelUseCase.getTrainingType(by: exercise ?? TrainingInfoModel(name: "", description: "", image: UIImage()))
    }
    
    func getFailurePhrase() -> String {
        return getFailurePhraseUseCase.getPhrase(trainingType: getTrainingType(), repsLeft: repsLeft ?? 0)
    }
    
}

// MARK: - Navigation
extension ExerciseResultViewModel {
    func goToMainScreen() {
        coordinator?.goToMainScreen()
    }
}
