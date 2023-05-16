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
    
}
