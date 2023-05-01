//
//  AuthorizationViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import Foundation

final class AuthorizationViewModel {
    
    weak var coordinator: AuthCoordinator?
    var userName = ""
    
    func goToAuthorizationPinPanelScreen() {
        self.coordinator?.goToAuthorizationPinPanelScreen(userName: self.userName)
    }
    
}
