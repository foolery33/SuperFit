//
//  GetMostRecentPhotoUseCase.swift
//  SuperFit-Lab2
//
//  Created by admin on 16.05.2023.
//

import Foundation

final class GetMostRecentPhotoUseCase {

    func getPhoto(from photos: [ProfilePhotoModel]) -> ProfilePhotoModel? {
        return photos.sorted { $0.uploaded < $1.uploaded }.first
    }

}
