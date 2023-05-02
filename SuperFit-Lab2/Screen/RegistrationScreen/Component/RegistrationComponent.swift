//
//  RegistrationComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import UIKit
import NeedleFoundation

protocol RegistrationComponentDependency: Dependency {
    var authRepository: AuthRepository { get }
    var saveRefreshTokenUseCase: SaveRefreshTokenUseCase { get }
    var saveUserEmailUseCase: SaveUserEmailUseCase { get }
    var getRegisterValidationErrorUseCase: GetRegisterValidationErrorUseCase { get }
    var codeValueChangeUseCase: CodeValueChangeUseCase { get }
}

final class RegistrationComponent: Component<RegistrationComponentDependency> {
    var registrationViewModel: RegistrationViewModel {
        shared {
            RegistrationViewModel(
                authRepository: dependency.authRepository,
                saveRefreshTokenUseCase: dependency.saveRefreshTokenUseCase,
                saveUserEmailUseCase: dependency.saveUserEmailUseCase,
                getRegisterValidationErrorUseCase: dependency.getRegisterValidationErrorUseCase,
                codeValueChangeUseCase: dependency.codeValueChangeUseCase
            )
        }
    }
    
    var registrationViewController: UIViewController {
        return RegistrationViewController(viewModel: registrationViewModel)
    }
}
