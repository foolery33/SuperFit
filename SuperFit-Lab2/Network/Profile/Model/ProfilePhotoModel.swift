//
//  ProfilePhotoModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import Foundation

struct ProfilePhotoModel: Decodable, Equatable {

    var id: UUID
    var uploaded: TimeInterval

}
