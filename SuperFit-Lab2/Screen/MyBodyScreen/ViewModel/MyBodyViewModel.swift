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
    private let profilePhotosRepository: ProfilePhotosRepository
    private let getMostRecentPhotoUseCase: GetMostRecentPhotoUseCase
    private let getLatestPhotoUseCase: GetLatestPhotoUseCase
    private let getBodyParametersValidationErrorUseCase: GetBodyParametersValidationErrorUseCase
    private let convertDateToYyyyMmDdUseCase: ConvertDateToYyyyMmDdUseCase
    private let convertTimestampToDdMmYyyyUseCase: ConvertTimestampToDdMmYyyyUseCase

    private(set) var beforePhotoData: Data?
    private(set) var afterPhotoData: Data?

    var weight: Int?
    var height: Int?

    var profilePhotos: [ProfilePhotoModel] = []

    init(profileRepository: ProfileRepository,
         userBodyParametersRepository: UserBodyParametersRepository,
         profilePhotosRepository: ProfilePhotosRepository,
         getMostRecentPhotoUseCase: GetMostRecentPhotoUseCase,
         getLatestPhotoUseCase: GetLatestPhotoUseCase,
         getBodyParametersValidationErrorUseCase: GetBodyParametersValidationErrorUseCase,
         convertDateToYyyyMmDdUseCase: ConvertDateToYyyyMmDdUseCase,
         convertTimestampToDdMmYyyyUseCase: ConvertTimestampToDdMmYyyyUseCase) {
        self.profileRepository = profileRepository
        self.userBodyParametersRepository = userBodyParametersRepository
        self.profilePhotosRepository = profilePhotosRepository
        self.getMostRecentPhotoUseCase = getMostRecentPhotoUseCase
        self.getLatestPhotoUseCase = getLatestPhotoUseCase
        self.getBodyParametersValidationErrorUseCase = getBodyParametersValidationErrorUseCase
        self.convertDateToYyyyMmDdUseCase = convertDateToYyyyMmDdUseCase
        self.convertTimestampToDdMmYyyyUseCase = convertTimestampToDdMmYyyyUseCase

        self.weight = userBodyParametersRepository.fetchWeight()
        self.height = userBodyParametersRepository.fetchHeight()
    }

    func updateWeight(with weight: String) {
        self.weight = Int(weight) ?? -1
    }
    func getWeight() -> String {
        return String(userBodyParametersRepository.fetchWeight() ?? -1)
    }
    func updateHeight(with height: String) {
        self.height = Int(height) ?? -1
    }
    func getHeight() -> String {
        return String(userBodyParametersRepository.fetchHeight() ?? -1)
    }

    func convertTimestampToDdMmYyyy(_ timestamp: TimeInterval) -> String {
        convertTimestampToDdMmYyyyUseCase.convert(timestamp)
    }

    func getBeforePhotoWithDate() -> (UIImage?, String?) {
        return profilePhotosRepository.loadBeforePhotoWithDate()
    }
    func getAfterPhotoWithDate() -> (UIImage?, String?) {
        return profilePhotosRepository.loadAfterPhotoWithDate()
    }

    func cacheBeforePhotoWithDate(data: Data, dateOfPhoto: String) {
        profilePhotosRepository.cacheBeforePhotoWithDate(data: data, dateOfPhoto: dateOfPhoto)
    }
    func cacheAfterPhotoWithDate(data: Data, dateOfPhoto: String) {
        profilePhotosRepository.cacheAfterPhotoWithDate(data: data, dateOfPhoto: dateOfPhoto)
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

    func goToTrainProgressScreen() {
        coordinator?.goToTrainProgressScreen()
    }

    func goToStatisticsScreen() {
        coordinator?.goToStatisticsScreen()
    }
}

// MARK: - Network requests
extension MyBodyViewModel {

    func getProfilePhotos() async {
        do {
            profilePhotos = try await profileRepository.getProfilePhotos()
            beforePhotoData = await downloadUserPhoto(
                photoId: getMostRecentPhotoUseCase.getPhoto(
                    from: profilePhotos
                )?.id ?? UUID()
            )
            afterPhotoData = await downloadUserPhoto(
                photoId: getLatestPhotoUseCase.getPhoto(
                    from: profilePhotos
                )?.id ?? UUID()
            )
        } catch let error {
            if let appError = error as? AppError {
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            } else {
                errorHandlingDelegate?.handleErrorMessage(error.localizedDescription)
            }
        }
    }

    func downloadUserPhoto(photoId: UUID) async -> Data? {
        do {
            return try await profileRepository.downloadUserPhoto(photoId: photoId)
        } catch let error {
            if let appError = error as? AppError {
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            } else {
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
            // Если пользователь ввёл невалидные данные, то сохраняем изначальные данные (до нажатия на ОК в поле ввода)
            if weight == -1 || weight == nil {
                weight = (
                    userBodyParametersRepository.fetchWeight() == nil
                ) ? -1 : userBodyParametersRepository.fetchWeight()
            }
            if height == -1 || height == nil {
                height = (
                    userBodyParametersRepository.fetchHeight() == nil
                ) ? -1 : userBodyParametersRepository.fetchHeight()
            }
            return false
        } else {
            userBodyParametersRepository.saveWeight(weight ?? -1)
            userBodyParametersRepository.saveHeight(height ?? -1)
        }
        do {
            _ = try await profileRepository.updateUserParameters(
                newParameters: BodyParametersModel(
                    weight: userBodyParametersRepository.fetchWeight()!,
                    height: userBodyParametersRepository.fetchHeight()!,
                    date: convertDateToYyyyMmDdUseCase.convert(Date())
                )
            )
            return true

        } catch let error {
            if let appError = error as? AppError {
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            } else {
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
