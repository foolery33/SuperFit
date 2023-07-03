//
//  LastExercisesManagerRepository.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 26.06.2023.
//

import Foundation

protocol LastExercisesRepository {

    func saveLastExercise(trainingType: TrainingTypeModel)
    func savePreLastExercise(trainingType: TrainingTypeModel)

    func fetchLastExercise() -> String
    func fetchPreLastExercise() -> String

    func isThereSavedExercises() -> Bool

    func getLastExercises() -> [TrainingTypeModel]

    func clearAllData()

}
