//
//  ExercisesViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import Foundation

final class ExercisesViewModel {
    
    weak var coordinator: ExercisesCoordinator?
    private let model = ExercisesModel()
    
    var exercises: [TrainingInfoModel] {
        get {
            model.exercises
        }
    }
    
    func goToPreviousScreen() {
        coordinator?.navigationController.popViewController(animated: true)
    }
    
}
