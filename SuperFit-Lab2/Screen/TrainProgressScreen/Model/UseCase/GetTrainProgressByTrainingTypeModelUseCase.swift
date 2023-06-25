//
//  GetTrainProgressByTrainingTypeModel.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 25.06.2023.
//

import Foundation

final class GetTrainProgressByTrainingTypeModelUseCase {
    
    func calculateTrainingProgress(trainingType: TrainingTypeModel, trainingList: [TrainingModel]) -> TrainingProgressModel? {
        guard let latestTraining = trainingList
            .filter({ $0.exercise == trainingType })
            .sorted(by: { $0.date > $1.date })
            .first else {
            return nil
        }
        
        var progress: String = ""
        var lastTrain: String = "\(latestTraining.repeatCount) \(getUnit(for: trainingType) ?? "")"
        
        if let secondLatestTraining = trainingList
            .filter({ $0.exercise == trainingType })
            .sorted(by: { $0.date > $1.date })
            .dropFirst()
            .first {
            let progressPercentage = calculateProgressPercentage(latestTraining.repeatCount, secondLatestTraining.repeatCount)
            progress = "\(progressPercentage)%"
            
            if let unit = getUnit(for: trainingType) {
                lastTrain = "\(latestTraining.repeatCount) \(unit)"
            } else {
                lastTrain = "\(latestTraining.repeatCount)"
            }
        }
        
        return TrainingProgressModel(lastTrain: lastTrain, progress: progress)
    }
    
    private func calculateProgressPercentage(_ latestCount: Int, _ secondLatestCount: Int) -> Int {
        let progress = ((latestCount - secondLatestCount) * 100) / secondLatestCount
        return progress
    }
    
    func getUnit(for trainingType: TrainingTypeModel) -> String? {
        switch trainingType {
        case .crunch, .squats, .pushUps:
            return R.string.trainProgressScreen.times()
        case .plank:
            return R.string.trainProgressScreen.seconds()
        case .running:
            return R.string.trainProgressScreen.meters()
        }
    }
    
}
