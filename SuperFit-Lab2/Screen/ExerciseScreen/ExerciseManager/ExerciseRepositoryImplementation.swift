//
//  ExerciseManagerRepositoryImplementation.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 26.06.2023.
//

import Foundation

final class ExerciseRepositoryImplementation: ExerciseRepository {
    
    func saveTraining(trainingType: TrainingTypeModel) {
        switch trainingType {
        case .squats, .crunch, .pushUps:
            UserDefaults.standard.set(getRepsCount(for: trainingType) + 5, forKey: trainingType.rawValue)
        case .running:
            UserDefaults.standard.set(getRepsCount(for: trainingType) + 100, forKey: trainingType.rawValue)
        case .plank:
            UserDefaults.standard.set(getRepsCount(for: trainingType) + 5, forKey: trainingType.rawValue)
        }
    }
    
    func getRepsCount(for trainingType: TrainingTypeModel) -> Int {
        let repsCount = UserDefaults.standard.integer(forKey: trainingType.rawValue)
        if repsCount == 0 {
            switch trainingType {
            case .squats, .crunch, .pushUps:
                UserDefaults.standard.set(10, forKey: trainingType.rawValue)
            case .running:
                UserDefaults.standard.set(1000, forKey: trainingType.rawValue)
            case .plank:
                UserDefaults.standard.set(20, forKey: trainingType.rawValue)
            }
        }
        return UserDefaults.standard.integer(forKey: trainingType.rawValue)
    }
    
}
