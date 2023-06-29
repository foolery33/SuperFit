//
//  ProfilePhotosRepository.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 27.06.2023.
//

import UIKit

protocol ProfilePhotosRepository {
    func cacheBeforePhotoWithDate(data: Data, dateOfPhoto: String)
    func loadBeforePhotoWithDate() -> (UIImage?, String?)
    
    func cacheAfterPhotoWithDate(data: Data, dateOfPhoto: String)
    func loadAfterPhotoWithDate() -> (UIImage?, String?)
    
    func clearAllData()
}
