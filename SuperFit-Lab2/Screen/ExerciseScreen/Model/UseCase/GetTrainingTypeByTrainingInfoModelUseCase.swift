//
//  GetTrainingTypeByTrainingInfoModelUseCase.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import Foundation

final class GetTrainingTypeByTrainingInfoModelUseCase {
    
    func getTrainingType(by trainingInfoModel: TrainingInfoModel) -> TrainingTypeModel {
        switch trainingInfoModel.name {
        case R.string.mainScreenStrings.push_ups():
            return TrainingTypeModel.pushUps
        case R.string.mainScreenStrings.plank():
            return TrainingTypeModel.plank
        case R.string.mainScreenStrings.squats():
            return TrainingTypeModel.squats
        case R.string.mainScreenStrings.crunch():
            return TrainingTypeModel.crunch
        case R.string.mainScreenStrings.running():
            return TrainingTypeModel.running
        default:
            return TrainingTypeModel.pushUps
        }
    }
    
}
