//
//  AuthorizationComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import NeedleFoundation
import UIKit

protocol AuthorizationComponentDependency: Dependency {
//    var loginUseCase: LoginUseCase { get }
}

final class AuthorizationComponent: Component<AuthorizationComponentDependency> {
    var authorizationViewModel: AuthorizationViewModel {
        shared {
            AuthorizationViewModel()
        }
    }
    
    var authorizationViewController: UIViewController {
        return AuthorizationViewController(viewModel: authorizationViewModel)
    }
}
