//
//  GetTwoLastExercisesUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 26.06.2023.
//

import Foundation

final class GetTwoLastExercisesUseCase {
    
    func getExercises(from trainingModels: [TrainingModel]) -> [TrainingModel] {
        // Сортировка по убыванию даты
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let sortedModels = trainingModels.sorted { model1, model2 in
            guard let date1 = dateFormatter.date(from: model1.date),
                  let date2 = dateFormatter.date(from: model2.date) else {
                return false
            }
            return date1 > date2
        }
        
        // Поиск 2-х последних моделей с разными упражнениями
        var latestModels: [TrainingModel] = []
        var uniqueExercises: Set<TrainingTypeModel> = []
        
        for model in sortedModels {
            if uniqueExercises.contains(model.exercise) {
                continue
            }
            
            latestModels.append(model)
            uniqueExercises.insert(model.exercise)
            
            if latestModels.count == 2 {
                break
            }
        }
        
        return latestModels
    }
    
}
