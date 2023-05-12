//
//  GetTrainingInfoByIdUseCase.swift
//  SuperFit-Lab2
//
//  Created by admin on 03.05.2023.
//

import Foundation

final class GetTrainingInfoModelByTrainingTypeModelUseCase {
    func getTrainingInfo(_ trainingModel: TrainingTypeModel) -> TrainingInfoModel {
        switch trainingModel {
        case .pushUp:
            return TrainingInfoModel(name: R.string.mainScreenStrings.push_ups(), description: R.string.mainScreenStrings.push_ups_description(), image: R.image.pushUps()!)
        case .plank:
            return TrainingInfoModel(name: R.string.mainScreenStrings.plank(), description: R.string.mainScreenStrings.plank_description(), image: R.image.plank()!)
        case .squats:
            return TrainingInfoModel(name: R.string.mainScreenStrings.squats(), description: R.string.mainScreenStrings.squats_description(), image: R.image.squats()!)
        case .crunch:
            return TrainingInfoModel(name: R.string.mainScreenStrings.crunch(), description: R.string.mainScreenStrings.crunch_description(), image: R.image.crunch()!)
        case .running:
            return TrainingInfoModel(name: R.string.mainScreenStrings.running(), description: R.string.mainScreenStrings.running_description(), image: R.image.running()!)
        }
    }
}
