//
//  ImageListViewModel.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 23.06.2023.
//

import Foundation

final class ImageListViewModel {

    weak var coordinator: MyBodyCoordinator?
    weak var errorHandlingDelegate: ErrorHandlingDelegate?

    private let profileRepository: ProfileRepository
    private let groupPhotosByMonthUseCase: GroupPhotosByMonthUseCase
    private let getMonthAndYearByTimeIntervalUseCase: GetMonthAndYearByTimeIntervalUseCase

    var profilePhotos: [ProfilePhotoModel]?
    var profilePhotosData: [Data] = []
    var groupedProfilePhotos: [[ProfilePhotoModel]] = []
    var groupedProfilePhotosData: [[Data]] = []

    init(
        profileRepository: ProfileRepository,
        groupPhotosByMonthUseCase: GroupPhotosByMonthUseCase,
        getMonthAndYearByTimeIntervalUseCase: GetMonthAndYearByTimeIntervalUseCase
    ) {
        self.profileRepository = profileRepository
        self.groupPhotosByMonthUseCase = groupPhotosByMonthUseCase
        self.getMonthAndYearByTimeIntervalUseCase = getMonthAndYearByTimeIntervalUseCase
    }

    func setProfilePhotos(_ profilePhotos: [ProfilePhotoModel]) {
        self.profilePhotos = profilePhotos
        if !profilePhotos.isEmpty {
            self.profilePhotos![0].uploaded = 1559347200
        }
        groupedProfilePhotos = groupPhotosByMonthUseCase.group(self.profilePhotos ?? [])
        groupedProfilePhotosData = []
    }

    func getMonthAndYearByTimeInterval(_ interval: TimeInterval) -> String {
        getMonthAndYearByTimeIntervalUseCase.getString(interval)
    }

    func goToImageScreen(imageData: Data) {
        coordinator?.goToImageScreen(imageData: imageData)
    }

}

// MARK: - Navigation
extension ImageListViewModel {
    func goToPreviousScreen() {
        coordinator?.navigationController.popViewController(animated: true)
    }
    func reauthenticateUser() {
        coordinator?.reauthenticateUser()
    }
}

// MARK: - Network requests
extension ImageListViewModel {
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
}
