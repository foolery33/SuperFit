//
//  TrainingTypeModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import Foundation

enum TrainingTypeModel: String, Decodable {
    case crunch = "CRUNCH"
    case squats = "SQUATS"
    case pushUps = "PUSH_UP"
    case plank = "PLANK"
    case running = "RUNNING"

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case TrainingTypeModel.crunch.rawValue:
            self = .crunch
        case TrainingTypeModel.squats.rawValue:
            self = .squats
        case TrainingTypeModel.pushUps.rawValue:
            self = .pushUps
        case TrainingTypeModel.plank.rawValue:
            self = .plank
        case TrainingTypeModel.running.rawValue:
            self = .running
        default:
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid training type: \(rawValue)"
            )
        }
    }
}
