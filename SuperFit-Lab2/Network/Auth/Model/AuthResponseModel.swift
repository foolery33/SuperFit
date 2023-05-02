//
//  AuthResponseModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

struct AuthResponseModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
    
    init(refreshToken: String) {
        self.refreshToken = refreshToken
    }
    
    var refreshToken: String
    
}
