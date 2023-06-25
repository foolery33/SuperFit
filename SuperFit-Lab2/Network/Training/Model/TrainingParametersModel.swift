//
//  TrainingParametersModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import Foundation

struct TrainingParametersModel: Codable {
    let date: String
    let exercise: String
    let repeatCount: Int
    
    init(date: String, exercise: String, repeatCount: Int) {
        self.date = date
        self.exercise = exercise
        self.repeatCount = repeatCount
    }
    
}
