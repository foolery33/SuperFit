//
//  GarbageManager.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 27.06.2023.
//

final class GarbageManager {

    private let userDataManager: UserDataManagerRepository
    private let profilePhotosRepository: ProfilePhotosRepository
    private let lastExercisesRepository: LastExercisesRepository
    private let userBodyParametersRepository: UserBodyParametersRepository

    init(
        userDataManager: UserDataManagerRepository,
        profilePhotosRepository: ProfilePhotosRepository,
        lastExercisesRepository: LastExercisesRepository,
        userBodyParametersRepository: UserBodyParametersRepository
    ) {
        self.userDataManager = userDataManager
        self.profilePhotosRepository = profilePhotosRepository
        self.lastExercisesRepository = lastExercisesRepository
        self.userBodyParametersRepository = userBodyParametersRepository
    }

    func clearAllData() {
        userDataManager.clearAllData()
        profilePhotosRepository.clearAllData()
        lastExercisesRepository.clearAllData()
        userBodyParametersRepository.clearAllData()
    }

}
