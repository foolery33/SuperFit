//
//  AuthorizationPinPanelComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import NeedleFoundation
import UIKit

protocol AuthorizationPinPanelComponentDependency: Dependency {

}

final class AuthorizationPinPanelComponent: Component<AuthorizationPinPanelComponentDependency> {
    var authorizationPinPanelViewModel: AuthorizationPinPanelViewModel {
        shared {
            AuthorizationPinPanelViewModel()
        }
    }
    
    var authorizationPinPanelViewController: UIViewController {
        return AuthorizationPinPanelViewController(viewModel: authorizationPinPanelViewModel)
    }
}
