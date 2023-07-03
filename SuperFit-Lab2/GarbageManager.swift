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

    static var shared: GarbageManager = {
        let userDataManager = UserDataManagerRepositoryImplementation()
        let profilePhotosRepository = ProfilePhotosRepositoryImplementation()
        let lastExercisesRepository = LastExercisesRepositoryImplementation(
            getTrainingTypeModelByTrainingNameUseCase:
                GetTrainingTypeModelByTrainingNameUseCase()
        )
        let userBodyParametersRepository = UserBodyParametersRepositoryImplementation()

        return GarbageManager(
            userDataManager: userDataManager,
            profilePhotosRepository: profilePhotosRepository,
            lastExercisesRepository: lastExercisesRepository,
            userBodyParametersRepository: userBodyParametersRepository
        )
    }()

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
