//
//  ExerciseManagerRepository.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 26.06.2023.
//

import Foundation

protocol ExerciseRepository {
    
    func saveTraining(trainingType: TrainingTypeModel)
    func getRepsCount(for trainingType: TrainingTypeModel) -> Int
    
}
