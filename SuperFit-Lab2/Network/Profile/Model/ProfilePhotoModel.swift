//
//  ProfilePhotoModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import Foundation

struct ProfilePhotoModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case uploaded = "uploaded"
    }
    
    init(id: UUID, uploaded: TimeInterval) {
        self.id = id
        self.uploaded = uploaded
    }
    
    var id: UUID
    var uploaded: TimeInterval
    
}
