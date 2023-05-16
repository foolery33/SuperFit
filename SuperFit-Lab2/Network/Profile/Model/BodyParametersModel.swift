//
//  BodyParametersModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import Foundation

struct BodyParametersModel: Decodable, Encodable {
    
    enum CodingKeys: String, CodingKey {
        case weight = "weight"
        case height = "height"
        case date = "date"
    }
    
    init(weight: Int, height: Int, date: String) {
        self.weight = weight
        self.height = height
        self.date = date
    }
    
    var weight: Int
    var height: Int
    var date: String
    
}
