//
//  TrainingModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import Foundation

struct TrainingModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case exercise = "exercise"
        case repeatCount = "repeatCount"
    }
    
    var date: String
    var exercise: TrainingTypeModel
    var repeatCount: Int
}
