//
//  AuthorizationComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import NeedleFoundation
import UIKit

protocol AuthorizationComponentDependency: Dependency {
    var userDataManagerRepository: UserDataManagerRepository { get }
    var emptyValidationUseCase: EmptyValidationUseCase { get }
}

final class AuthorizationComponent: Component<AuthorizationComponentDependency> {
    var authorizationViewModel: AuthorizationViewModel {
        shared {
            AuthorizationViewModel(
                userDataManagerRepository: dependency.userDataManagerRepository,
                emptyValidationUseCase: dependency.emptyValidationUseCase
            )
        }
    }

    var authorizationViewController: UIViewController {
        return AuthorizationViewController(viewModel: authorizationViewModel)
    }
}
