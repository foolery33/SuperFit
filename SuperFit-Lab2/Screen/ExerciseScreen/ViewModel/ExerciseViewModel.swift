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
    var exercise: TrainingInfoModel?
    
    private let getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase
    
    init(getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase) {
        self.getTrainingTypeByTrainingInfoModelUseCase = getTrainingTypeByTrainingInfoModelUseCase
    }
    
    func getTrainingType() -> TrainingTypeModel {
        getTrainingTypeByTrainingInfoModelUseCase.getTrainingType(by: exercise ?? TrainingInfoModel(name: "", description: "", image: UIImage()))
    }
    
    func goToPreviousScreen() {
        coordinator?.navigationController.popViewController(animated: true)
    }
    
}
