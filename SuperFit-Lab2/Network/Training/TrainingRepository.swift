//
//  TrainingRepository.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import Foundation

protocol TrainingRepository {
    func getTrainingList() async throws -> [TrainingModel]
    func saveTraining(training: TrainingModel) async throws -> TrainingModel
}
