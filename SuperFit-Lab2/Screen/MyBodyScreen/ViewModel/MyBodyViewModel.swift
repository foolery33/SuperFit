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
    weak var errorHandlingDelegate: ErrorHandlingDelegate?
    
    private let profileRepository: ProfileRepository
    private let userBodyParametersRepository: UserBodyParametersRepository
    private let getMostRecentPhotoUseCase: GetMostRecentPhotoUseCase
    private let getLatestPhotoUseCase: GetLatestPhotoUseCase
    private let getLastBodyParametersUseCase: GetLastBodyParametersUseCase
    private let getBodyParametersValidationErrorUseCase: GetBodyParametersValidationErrorUseCase
    private let convertDateToYyyyMmDdUseCase: ConvertDateToYyyyMmDdUseCase
    private let convertTimestampToDdMmYyyyUseCase: ConvertTimestampToDdMmYyyyUseCase
    
    private(set) var beforePhotoData: Data?
    private(set) var afterPhotoData: Data?
    
    var weight: Int?
    var height: Int?
    
    var bodyParameters: [BodyParametersModel] = []
    var profilePhotos: [ProfilePhotoModel] = []
    
    init(profileRepository: ProfileRepository,
         userBodyParametersRepository: UserBodyParametersRepository,
         getMostRecentPhotoUseCase: GetMostRecentPhotoUseCase,
         getLatestPhotoUseCase: GetLatestPhotoUseCase,
         getLastBodyParametersUseCase: GetLastBodyParametersUseCase,
         getBodyParametersValidationErrorUseCase: GetBodyParametersValidationErrorUseCase,
         convertDateToYyyyMmDdUseCase: ConvertDateToYyyyMmDdUseCase,
         convertTimestampToDdMmYyyyUseCase: ConvertTimestampToDdMmYyyyUseCase) {
        self.profileRepository = profileRepository
        self.userBodyParametersRepository = userBodyParametersRepository
        self.getMostRecentPhotoUseCase = getMostRecentPhotoUseCase
        self.getLatestPhotoUseCase = getLatestPhotoUseCase
        self.getLastBodyParametersUseCase = getLastBodyParametersUseCase
        self.getBodyParametersValidationErrorUseCase = getBodyParametersValidationErrorUseCase
        self.convertDateToYyyyMmDdUseCase = convertDateToYyyyMmDdUseCase
        self.convertTimestampToDdMmYyyyUseCase = convertTimestampToDdMmYyyyUseCase
        
        self.weight = userBodyParametersRepository.fetchWeight()
        self.height = userBodyParametersRepository.fetchHeight()
    }
    
    func updateWeight(with weight: String) {
        print(weight)
        self.weight = Int(weight)
    }
    func getWeight() -> String {
        print(String(userBodyParametersRepository.fetchWeight() ?? -1))
        return String(userBodyParametersRepository.fetchWeight() ?? -1)
    }
    func updateHeight(with height: String) {
        print(height)
        self.height = Int(height)
    }
    func getHeight() -> String {
        print(String(userBodyParametersRepository.fetchHeight() ?? -1))
        return String(userBodyParametersRepository.fetchHeight() ?? -1)
    }
    
    func convertTimestampToDdMmYyyy(_ timestamp: TimeInterval) -> String {
        convertTimestampToDdMmYyyyUseCase.convert(timestamp)
    }
    
}

// MARK: - Navigation
extension MyBodyViewModel {
    func reauthenticateUser() {
        coordinator?.reauthenticateUser()
    }
    
    func goToPreviousScreen() {
        coordinator?.navigationController.popViewController(animated: true)
    }
    
    func goToImageListScreen() {
        coordinator?.goToImageListScreen(profilePhotos: profilePhotos)
    }
}

// MARK: - Network requests
extension MyBodyViewModel {
    func getUserParameters() async -> Bool {
        do {
            bodyParameters = try await profileRepository.getUserParameters()
            return true
        } catch(let error) {
            if let appError = error as? AppError {
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            }
            else {
                errorHandlingDelegate?.handleErrorMessage(error.localizedDescription)
            }
            return false
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
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            }
            else {
                errorHandlingDelegate?.handleErrorMessage(error.localizedDescription)
            }
            return false
        }
    }
    
    func downloadUserPhoto(photoId: UUID) async -> Data? {
        do {
            return try await profileRepository.downloadUserPhoto(photoId: photoId)
        } catch(let error) {
            if let appError = error as? AppError {
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            }
            else {
                errorHandlingDelegate?.handleErrorMessage(error.localizedDescription)
            }
            return nil
        }
    }
    
    func updateUserParameters() async -> Bool {
        if let bodyParametersError = getBodyParametersValidationErrorUseCase.getError(
            weight: weight,
            height: height
        ) {
            errorHandlingDelegate?.handleErrorMessage(bodyParametersError)
            // Сохраняем изначальные данные (до нажатия на ОК в поле ввода)
            weight = userBodyParametersRepository.fetchWeight()
            height = userBodyParametersRepository.fetchHeight()
            return false
        }
        else {
            userBodyParametersRepository.saveWeight(weight ?? -1)
            userBodyParametersRepository.saveHeight(height ?? -1)
        }
        do {
            let _ = try await profileRepository.updateUserParameters(
                newParameters: BodyParametersModel(
                    weight: userBodyParametersRepository.fetchWeight()!,
                    height: userBodyParametersRepository.fetchHeight()!,
                    date: convertDateToYyyyMmDdUseCase.convert(Date())
                )
            )
            return true
            
        } catch(let error) {
            if let appError = error as? AppError {
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            }
            else {
                errorHandlingDelegate?.handleErrorMessage(error.localizedDescription)
            }
            return false
        }
    }
    
    func uploadPhoto(imageData: Data, completion: @escaping (Bool) -> Void) {
        profileRepository.uploadPhoto(imageData: imageData) { [weak self] result in
            switch result {
            case .success(let data):
                self?.profilePhotos.append(data)
                completion(true)
            case .failure(let error):
                self?.errorHandlingDelegate?.handleErrorMessage(error.errorDescription)
            }
        }
    }
}
