//
//  GetFailurePhraseUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 26.06.2023.
//

import Foundation

final class GetFailurePhraseUseCase {
    
    func getPhrase(trainingType: TrainingTypeModel, repsLeft: Int) -> String {
        switch trainingType {
        case .crunch, .squats, .pushUps:
            return "\(repsLeft) \(R.string.exerciseResultScreen.times()) \(R.string.exerciseResultScreen.unsuccess_phrase())"
        case .running:
            return "\(repsLeft) \(R.string.exerciseResultScreen.meters()) \(R.string.exerciseResultScreen.unsuccess_phrase())"
        case .plank:
            return "\(repsLeft) \(R.string.exerciseResultScreen.seconds()) \(R.string.exerciseResultScreen.unsuccess_phrase())"
        }
    }
    
}
