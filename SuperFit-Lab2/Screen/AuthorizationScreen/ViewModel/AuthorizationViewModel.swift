//
//  AuthorizationViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import Foundation

final class AuthorizationViewModel {
    
    weak var coordinator: AuthCoordinator?
    var emptyValidationUseCase: EmptyValidationUseCase
    var email = UserDataManager().fetchEmail()
    
    var error: String = ""
    
    init(emptyValidationUseCase: EmptyValidationUseCase) {
        self.emptyValidationUseCase = emptyValidationUseCase
    }
    
    func goToAuthorizationPinPanelScreen() {
        self.coordinator?.goToAuthorizationPinPanelScreen(email: self.email)
    }
    
    func onSignInButtonClicked(completion: @escaping (Bool) -> Void) {
        if emptyValidationUseCase.isEmptyField(email) {
            self.error = R.string.errors.empty_email()
            completion(false)
        }
        else {
            completion(true)
        }
    }
    
    func goToRegistrationScreen() {
        self.coordinator?.goToRegistrationScreen()
    }
    
}
