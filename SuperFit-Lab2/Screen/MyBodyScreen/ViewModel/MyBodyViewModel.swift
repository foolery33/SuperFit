//
//  MyBodyViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import Foundation
import UIKit

final class MyBodyViewModel {
    
    weak var coordinator: MyBodyCoordinator?
    private var model = MyBodyModel()
    private let profileRepository: ProfileRepository
    private let userBodyParametersRepository: UserBodyParametersRepository
    private let getMostRecentPhotoUseCase: GetMostRecentPhotoUseCase
    private let getLatestPhotoUseCase: GetLatestPhotoUseCase
    private let getLastBodyParametersUseCase: GetLastBodyParametersUseCase
    
    private(set) var beforePhotoData: Data?
    private(set) var afterPhotoData: Data?
    private(set) var lastBodyParameters: BodyParametersModel?
    var currentWeight: Int?
    var currentHeight: Int?
    
    private(set) var error: String = ""
    
    init(profileRepository: ProfileRepository,
         userBodyParametersRepository: UserBodyParametersRepository,
         getMostRecentPhotoUseCase: GetMostRecentPhotoUseCase,
         getLatestPhotoUseCase: GetLatestPhotoUseCase,
         getLastBodyParametersUseCase: GetLastBodyParametersUseCase) {
        self.profileRepository = profileRepository
        self.userBodyParametersRepository = userBodyParametersRepository
        self.getMostRecentPhotoUseCase = getMostRecentPhotoUseCase
        self.getLatestPhotoUseCase = getLatestPhotoUseCase
        self.getLastBodyParametersUseCase = getLastBodyParametersUseCase
    }
    
    var bodyParameters: [BodyParametersModel] {
        get {
            model.bodyParameters
        }
        set {
            model.bodyParameters = newValue
        }
    }

    func getUserParameters() async -> Bool {
        do {
            bodyParameters = try await profileRepository.getUserParameters()
            lastBodyParameters = getLastBodyParametersUseCase.getParameters(from: bodyParameters)
            return true
        } catch(let error){
            if let appError = error as? AppError {
                self.error = appError.errorDescription
            }
            else {
                self.error = error.localizedDescription
            }
            return false
        }
    }
    
    var profilePhotos: [ProfilePhotoModel] {
        get {
            model.profilePhotos
        }
        set {
            model.profilePhotos = newValue
        }
    }
    func getProfilePhotos() async -> Bool {
        do {
            profilePhotos = try await profileRepository.getProfilePhotos()
            beforePhotoData = await downloadUserPhoto(photoId: getMostRecentPhotoUseCase.getPhoto(from: profilePhotos)?.id ?? UUID())
            afterPhotoData = await downloadUserPhoto(photoId: getLatestPhotoUseCase.getPhoto(from: profilePhotos)?.id ?? UUID())
            return true
        } catch(let error) {
            if let appError = error as? AppError {
                self.error = appError.errorDescription
            }
            else {
                self.error = error.localizedDescription
            }
            return false
        }
    }
    
    func downloadUserPhoto(photoId: UUID) async -> Data? {
        do {
            return try await profileRepository.downloadUserPhoto(photoId: photoId)
        } catch(let error) {
            if let appError = error as? AppError {
                self.error = appError.errorDescription
            }
            else {
                self.error = error.localizedDescription
            }
            return nil
        }
    }
    
    func updateUserParameters() async -> Bool {
        if userBodyParametersRepository.fetchWeight() == nil {
            error = "Введите данные о весе, чтобы сохранить информацию на сервере"
            return false
        }
        if userBodyParametersRepository.fetchHeight() == nil {
            error = "Введите данные о росте, чтобы сохранить информацию на сервере"
            return false
        }
        do {
            let _ = try await profileRepository.updateUserParameters(
                newParameters: BodyParametersModel(
                    weight: userBodyParametersRepository.fetchWeight()!,
                    height: userBodyParametersRepository.fetchHeight()!,
                    date: "2023-12-12"
                )
            )
            return true
            
        } catch(let error) {
            if let appError = error as? AppError {
                self.error = appError.errorDescription
            }
            else {
                self.error = error.localizedDescription
            }
            return false
        }
    }
    
}
