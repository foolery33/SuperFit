//
//  MainScreenModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 03.05.2023.
//

import Foundation

struct MainModel {
    
    var lastExercises: [TrainingModel] = []
 
    func getTwoLastExercises(exercises: [TrainingModel]) -> [TrainingModel] {
        if exercises.count > 2 {
            var result = [TrainingModel]()
            let firstExercise = exercises[0]
            let secondExercise = exercises[1]
            result.append(firstExercise)
            result.append(secondExercise)
            return result
        }
        return exercises
    }
    
}
