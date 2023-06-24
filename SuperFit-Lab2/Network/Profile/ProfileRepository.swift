//
//  ProfileRepository.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import Foundation

protocol ProfileRepository {
    func getUserParameters() async throws -> [BodyParametersModel]
    func updateUserParameters(newParameters: BodyParametersModel) async throws -> SimpleMessageModel
    func getProfilePhotos() async throws -> [ProfilePhotoModel]
    func downloadUserPhoto(photoId: UUID) async throws -> Data
    func uploadPhoto(imageData: Data, completion: @escaping (Result<ProfilePhotoModel, AppError>) -> Void)
}
