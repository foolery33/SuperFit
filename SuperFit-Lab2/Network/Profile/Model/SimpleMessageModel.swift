//
//  SimpleMessageModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 16.05.2023.
//

import Foundation

struct SimpleMessageModel: Decodable {
    
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
    
    init(message: String) {
        self.message = message
    }
    
    var message: String
    
    
}
