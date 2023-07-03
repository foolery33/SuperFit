//
//  GetTrainProgressByTrainingTypeModel.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 25.06.2023.
//

import Foundation

final class GetTrainProgressByTrainingTypeModelUseCase {

    func calculateTrainingProgress(
        trainingType: TrainingTypeModel,
        trainingList: [TrainingModel]
    ) -> TrainingProgressModel? {

        guard var latestTrainingDate: String = trainingList
            .filter({ $0.exercise == trainingType })
            .sorted(by: { $0.date >= $1.date })
            .first?.date else {
                return nil
            }

        guard var latestTraining = trainingList
            .filter({ $0.exercise == trainingType && $0.date == latestTrainingDate })
            .sorted(by: { $0.repeatCount > $1.repeatCount })
            .first else {
            return nil
        }

        var progress: String = ""
        var lastTrain: String = "\(latestTraining.repeatCount) \(getUnit(for: trainingType) ?? "")"

        let filteredTrainingList = trainingList.filter { $0.date != latestTrainingDate }

        if let secondLatestTrainingDate: String = filteredTrainingList
            .filter({ $0.exercise == trainingType })
            .sorted(by: { $0.date >= $1.date })
            .first?.date {
            if let secondLatestTraining = filteredTrainingList
                .filter({ $0.exercise == trainingType && $0.date == secondLatestTrainingDate })
                .sorted(by: { $0.repeatCount > $1.repeatCount })
                .first {
                let progressPercentage = calculateProgressPercentage(
                    latestTraining.repeatCount,
                    secondLatestTraining.repeatCount
                )
                progress = "\(progressPercentage)%"

                if let unit = getUnit(for: trainingType) {
                    lastTrain = "\(latestTraining.repeatCount) \(unit)"
                } else {
                    lastTrain = "\(latestTraining.repeatCount)"
                }
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
