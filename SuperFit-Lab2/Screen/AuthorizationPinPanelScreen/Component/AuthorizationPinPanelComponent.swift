//
//  AuthorizationPinPanelComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import NeedleFoundation
import UIKit

protocol AuthorizationPinPanelComponentDependency: Dependency {
    var authRepository: AuthRepository { get }
    var saveRefreshTokenUseCase: SaveRefreshTokenUseCase { get }
    var saveUserEmailUseCase: SaveUserEmailUseCase { get }
}

final class AuthorizationPinPanelComponent: Component<AuthorizationPinPanelComponentDependency> {
    var authorizationPinPanelViewModel: AuthorizationPinPanelViewModel {
        shared {
            AuthorizationPinPanelViewModel(
                authRepository: dependency.authRepository,
                saveRefreshTokenUseCase: dependency.saveRefreshTokenUseCase,
                saveUserEmailUseCase: dependency.saveUserEmailUseCase
            )
        }
    }
    
    var authorizationPinPanelViewController: UIViewController {
        return AuthorizationPinPanelViewController(viewModel: authorizationPinPanelViewModel)
    }
}
