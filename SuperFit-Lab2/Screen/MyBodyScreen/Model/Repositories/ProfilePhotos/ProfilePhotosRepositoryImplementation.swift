//
//  ProfilePhotosRepositoryImplementation.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 27.06.2023.
//

import Kingfisher
import UIKit

final class ProfilePhotosRepositoryImplementation: ProfilePhotosRepository {

    private enum CodingKeys {
        static let beforePhoto = "before_photo"
        static let beforePhotoDate = "before_photo_date"

        static let afterPhoto = "after_photo"
        static let afterPhotoDate = "after_photo_date"
    }

    func cacheBeforePhotoWithDate(data: Data, dateOfPhoto: String) {
        KingfisherManager.shared.cache.store(
            UIImage(data: data)!,
            forKey: CodingKeys.beforePhoto,
            toDisk: true
        )
        UserDefaults.standard.set(dateOfPhoto, forKey: CodingKeys.beforePhotoDate)
    }

    func loadBeforePhotoWithDate() -> (UIImage?, String?) {
        return (
            KingfisherManager.shared.cache.retrieveImageInMemoryCache(
                forKey: CodingKeys.beforePhoto
            ),
            UserDefaults.standard.string(
                forKey: CodingKeys.beforePhotoDate
            )
        )
    }

    func cacheAfterPhotoWithDate(data: Data, dateOfPhoto: String) {
        KingfisherManager.shared.cache.store(
            UIImage(data: data)!,
            forKey: CodingKeys.afterPhoto,
            toDisk: true
        )
        UserDefaults.standard.set(dateOfPhoto, forKey: CodingKeys.afterPhotoDate)
    }

    func loadAfterPhotoWithDate() -> (UIImage?, String?) {
        return (
            KingfisherManager.shared.cache.retrieveImageInMemoryCache(
                forKey: CodingKeys.afterPhoto
            ),
            UserDefaults.standard.string(
                forKey: CodingKeys.afterPhotoDate
            )
        )
    }

    func clearAllData() {
        UserDefaults.standard.removeObject(forKey: CodingKeys.beforePhotoDate)
        UserDefaults.standard.removeObject(forKey: CodingKeys.afterPhotoDate)
        KingfisherManager.shared.cache.removeImage(forKey: CodingKeys.beforePhoto)
        KingfisherManager.shared.cache.removeImage(forKey: CodingKeys.afterPhoto)
    }
}
