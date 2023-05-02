//
//  AccessTokenModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

final class AccessTokenModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    var accessToken: String
    
}
