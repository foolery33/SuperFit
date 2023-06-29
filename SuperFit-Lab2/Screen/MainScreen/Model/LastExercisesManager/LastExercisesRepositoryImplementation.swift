//
//  LastExercisesRepositoryImplementation.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 26.06.2023.
//

import Foundation

final class LastExercisesRepositoryImplementation: LastExercisesRepository {
    
    private enum CodingKeys {
        static let lastExercise = "lastExercise"
        static let preLastExercise = "preLastExercise"
    }
    
    private let getTrainingTypeModelByTrainingNameUseCase: GetTrainingTypeModelByTrainingNameUseCase
    
    init(getTrainingTypeModelByTrainingNameUseCase: GetTrainingTypeModelByTrainingNameUseCase) {
        self.getTrainingTypeModelByTrainingNameUseCase = getTrainingTypeModelByTrainingNameUseCase
    }
    
    func saveLastExercise(trainingType: TrainingTypeModel) {
        // Устанавливаем предпоследнее значение
        let currentLastExerciseName = getTrainingTypeModelByTrainingNameUseCase.getTrainingTypeModel(by: fetchLastExercise())?.rawValue
        if trainingType.rawValue != currentLastExerciseName {
            UserDefaults.standard.set(currentLastExerciseName ?? "", forKey: CodingKeys.preLastExercise)
        }
        
        // Устанавливаем последнее значение
        UserDefaults.standard.set(trainingType.rawValue, forKey: CodingKeys.lastExercise)
    }
    
    func savePreLastExercise(trainingType: TrainingTypeModel) {
        UserDefaults.standard.set(trainingType.rawValue, forKey: CodingKeys.preLastExercise)
    }
    
    func fetchLastExercise() -> String {
        UserDefaults.standard.string(forKey: CodingKeys.lastExercise) ?? ""
    }
    
    func fetchPreLastExercise() -> String {
        UserDefaults.standard.string(forKey: CodingKeys.preLastExercise) ?? ""
    }

    func isThereSavedExercises() -> Bool {
        if fetchLastExercise().count > 0 || fetchPreLastExercise().count > 0 {
            return true
        }
        return false
    }
    
    func getLastExercises() -> [TrainingTypeModel] {
        let lastExerciseName = fetchLastExercise()
        let preLastExerciseName = fetchPreLastExercise()
        
        var exercises: [TrainingTypeModel] = []
        
        if let lastExercise = getTrainingTypeModelByTrainingNameUseCase.getTrainingTypeModel(by: lastExerciseName) {
            exercises.append(lastExercise)
        }
        if let preLastExercise = getTrainingTypeModelByTrainingNameUseCase.getTrainingTypeModel(by: preLastExerciseName) {
            exercises.append(preLastExercise)
        }
        return exercises
    }
    
    func clearAllData() {
        UserDefaults.standard.removeObject(forKey: CodingKeys.preLastExercise)
        UserDefaults.standard.removeObject(forKey: CodingKeys.lastExercise)
    }
    
}
