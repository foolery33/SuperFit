//
//  AuthorizationPinPanelViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import Foundation

final class AuthorizationPinPanelViewModel {
    
    weak var coordinator: AuthCoordinator?
    var userName: String = ""
    
    func goBackToAuthorizationScreen() {
        self.coordinator?.navigationController.popViewController(animated: true)
    }
    
}
