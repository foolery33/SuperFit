//
//  MainComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import NeedleFoundation
import UIKit

final class MainComponent: BootstrapComponent {

    // MARK: - Repositories
    var authRepository: AuthRepository {
        shared {
            AuthRepositoryImplementation()
        }
    }
    var trainingRepository: TrainingRepository {
        shared {
            TrainingRepositoryImplementation()
        }
    }
    var profileRepository: ProfileRepository {
        shared {
            ProfileRepositoryImplementation()
        }
    }
    var userBodyParametersRepository: UserBodyParametersRepository {
        shared {
            UserBodyParametersRepositoryImplementation()
        }
    }
    var exerciseManagerRepository: ExerciseRepository {
        shared {
            ExerciseRepositoryImplementation()
        }
    }
    var lastExercisesRepository: LastExercisesRepository {
        shared {
            LastExercisesRepositoryImplementation(
                getTrainingTypeModelByTrainingNameUseCase: getTrainingTypeModelByTrainingNameUseCase
            )
        }
    }
    var profilePhotosRepository: ProfilePhotosRepository {
        shared {
            ProfilePhotosRepositoryImplementation()
        }
    }
    var userDataManagerRepository: UserDataManagerRepository {
        shared {
            UserDataManagerRepositoryImplementation()
        }
    }

    // MARK: - Managers
    var garbageManager: GarbageManager {
        shared {
            GarbageManager(
                userDataManager: userDataManagerRepository,
                profilePhotosRepository: profilePhotosRepository,
                lastExercisesRepository: lastExercisesRepository,
                userBodyParametersRepository: userBodyParametersRepository
            )
        }
    }

    // MARK: - UseCases
    var saveUserEmailUseCase: SaveUserEmailUseCase {
        shared {
            SaveUserEmailUseCase()
        }
    }
    var saveRefreshTokenUseCase: SaveRefreshTokenUseCase {
        shared {
            SaveRefreshTokenUseCase()
        }
    }
    var emptyValidationUseCase: EmptyValidationUseCase {
        shared {
            EmptyValidationUseCase()
        }
    }
    var emailValidationUseCase: EmailValidationUseCase {
        shared {
            EmailValidationUseCase()
        }
    }
    var codesEqualityValidationUseCase: CodesEqualityValidationUseCase {
        shared {
            CodesEqualityValidationUseCase()
        }
    }
    var codeValidationUseCase: CodeValidationUseCase {
        shared {
            CodeValidationUseCase()
        }
    }
    var getRegisterValidationErrorUseCase: GetRegisterValidationErrorUseCase {
        shared {
            GetRegisterValidationErrorUseCase(
                emptyValidationUseCase: emptyValidationUseCase,
                emailValidationUseCase: emailValidationUseCase,
                codesEqualityValidationUseCase: codesEqualityValidationUseCase,
                codeValidationUseCase: codeValidationUseCase
            )
        }
    }
    var codeValueChangeUseCase: CodeValueChangeUseCase {
        shared {
            CodeValueChangeUseCase()
        }
    }
    var getTrainingInfoModelByTrainingTypeModelUseCase: GetTrainingInfoModelByTrainingTypeModelUseCase {
        shared {
            GetTrainingInfoModelByTrainingTypeModelUseCase()
        }
    }
    var getTrainingTypeByTrainingInfoModelUseCase: GetTrainingTypeByTrainingInfoModelUseCase {
        shared {
            GetTrainingTypeByTrainingInfoModelUseCase()
        }
    }
    var getMostRecentPhotoUseCase: GetMostRecentPhotoUseCase {
        shared {
            GetMostRecentPhotoUseCase()
        }
    }
    var getLastestPhotoUseCase: GetLatestPhotoUseCase {
        shared {
            GetLatestPhotoUseCase()
        }
    }
    var getLastBodyParametersUseCase: GetLastBodyParametersUseCase {
        shared {
            GetLastBodyParametersUseCase()
        }
    }
    var getEmptyBodyParametersErrorUseCase: GetEmptyBodyParametersErrorUseCase {
        shared {
            GetEmptyBodyParametersErrorUseCase()
        }
    }
    var getWeightValidationErrorUseCase: GetWeightValidationErrorUseCase {
        shared {
            GetWeightValidationErrorUseCase()
        }
    }
    var getHeightValidationErrorUseCase: GetHeightValidationErrorUseCase {
        shared {
            GetHeightValidationErrorUseCase()
        }
    }
    var getBodyParametersValidationErrorUseCase: GetBodyParametersValidationErrorUseCase {
        shared {
            GetBodyParametersValidationErrorUseCase(
                getEmptyBodyParametersErrorUseCase: getEmptyBodyParametersErrorUseCase,
                getWeightValidationErrorUseCase: getWeightValidationErrorUseCase,
                getHeightValidationErrorUseCase: getHeightValidationErrorUseCase
            )
        }
    }
    var convertDateToYyyyMmDdUseCase: ConvertDateToYyyyMmDdUseCase {
        shared {
            ConvertDateToYyyyMmDdUseCase()
        }
    }
    var convertTimestampToDdMmYyyyUseCase: ConvertTimestampToDdMmYyyyUseCase {
        shared {
            ConvertTimestampToDdMmYyyyUseCase()
        }
    }
    var groupPhotosByMonthUseCase: GroupPhotosByMonthUseCase {
        shared {
            GroupPhotosByMonthUseCase()
        }
    }
    var getMonthAndYearByTimeIntervalUseCase: GetMonthAndYearByTimeIntervalUseCase {
        shared {
            GetMonthAndYearByTimeIntervalUseCase()
        }
    }
    var getTrainProgressByTrainingTypeModelUseCase: GetTrainProgressByTrainingTypeModelUseCase {
        shared {
            GetTrainProgressByTrainingTypeModelUseCase()
        }
    }
    var getFailurePhraseUseCase: GetFailurePhraseUseCase {
        shared {
            GetFailurePhraseUseCase()
        }
    }
    var getTwoLastExercisesUseCase: GetTwoLastExercisesUseCase {
        shared {
            GetTwoLastExercisesUseCase()
        }
    }
    var getTrainingTypeModelByTrainingNameUseCase: GetTrainingTypeModelByTrainingNameUseCase {
        shared {
            GetTrainingTypeModelByTrainingNameUseCase()
        }
    }
    var getSortedTrainingDatesUseCase: GetSortedTrainingDatesUseCase {
        shared {
            GetSortedTrainingDatesUseCase()
        }
    }
    var getTrainingResultsUseCase: GetTrainingResultsUseCase {
        shared {
            GetTrainingResultsUseCase()
        }
    }
    var getWeightChangesUseCase: GetWeightChangesUseCase {
        shared {
            GetWeightChangesUseCase()
        }
    }
    var getNearestMultipleOfTenUseCase: GetNearestMultipleOfTenUseCase {
        shared {
            GetNearestMultipleOfTenUseCase()
        }
    }
    var getSortedWeightChangesDatesUseCase: GetSortedWeightChangesDatesUseCase {
        shared {
            GetSortedWeightChangesDatesUseCase()
        }
    }

    // MARK: - Components
    var authorizationComponent: AuthorizationComponent {
        shared {
            AuthorizationComponent(parent: self)
        }
    }
    var authorizationPinPanelComponent: AuthorizationPinPanelComponent {
        shared {
            AuthorizationPinPanelComponent(parent: self)
        }
    }
    var registrationComponent: RegistrationComponent {
        shared {
            RegistrationComponent(parent: self)
        }
    }
    var mainScreenComponent: MainScreenComponent {
        shared {
            MainScreenComponent(parent: self)
        }
    }
    var exercisesComponent: ExercisesComponent {
        shared {
            ExercisesComponent(parent: self)
        }
    }
    var exerciseComponent: ExerciseComponent {
        shared {
            ExerciseComponent(parent: self)
        }
    }
    var exerciseResultComponent: ExerciseResultComponent {
        shared {
            ExerciseResultComponent(parent: self)
        }
    }
    var myBodyComponent: MyBodyComponent {
        shared {
            MyBodyComponent(parent: self)
        }
    }
    var imageListComponent: ImageListComponent {
        shared {
            ImageListComponent(parent: self)
        }
    }
    var imageComponent: ImageComponent {
        shared {
            ImageComponent(parent: self)
        }
    }
    var trainProgressComponent: TrainProgressComponent {
        shared {
            TrainProgressComponent(parent: self)
        }
    }
    var statisticsComponent: StatisticsComponent {
        shared {
            StatisticsComponent(parent: self)
        }
    }

}
