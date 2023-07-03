//
//  GetTrainingInfoModelByTrainingNameUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 26.06.2023.
//

import Foundation

final class GetTrainingTypeModelByTrainingNameUseCase {

    private enum TrainingNames: String {
        case pushUps = "PUSH_UP"
        case plank = "PLANK"
        case squats = "SQUATS"
        case crunch = "CRUNCH"
        case running = "RUNNING"
    }

    func getTrainingTypeModel(by trainingName: String) -> TrainingTypeModel? {
        if trainingName == TrainingNames.pushUps.rawValue {
            return TrainingTypeModel.pushUps
        } else if trainingName == TrainingNames.plank.rawValue {
            return TrainingTypeModel.plank
        } else if trainingName == TrainingNames.squats.rawValue {
            return TrainingTypeModel.squats
        } else if trainingName == TrainingNames.crunch.rawValue {
            return TrainingTypeModel.crunch
        } else if trainingName == TrainingNames.running.rawValue {
            return TrainingTypeModel.running
        }
        return nil
    }

}
