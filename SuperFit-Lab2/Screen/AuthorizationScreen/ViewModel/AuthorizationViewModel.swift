//
//  AuthorizationViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import Foundation

final class AuthorizationViewModel {

    weak var coordinator: AuthCoordinator?
    weak var errorHandlingDelegate: ErrorHandlingDelegate?
    private let userDataManagerRepository: UserDataManagerRepository
    private let emptyValidationUseCase: EmptyValidationUseCase

    var email: String = ""

    init(
        userDataManagerRepository: UserDataManagerRepository,
        emptyValidationUseCase: EmptyValidationUseCase
    ) {
        self.userDataManagerRepository = userDataManagerRepository
        self.emptyValidationUseCase = emptyValidationUseCase

        email = userDataManagerRepository.fetchEmail()
    }

    func goToAuthorizationPinPanelScreen() {
        self.coordinator?.goToAuthorizationPinPanelScreen(email: self.email)
    }

    func onSignInButtonClicked() -> Bool {
        if emptyValidationUseCase.isEmptyField(email) {
            errorHandlingDelegate?.handleErrorMessage(R.string.errors.empty_email())
            return false
        }
        return true
    }

    func goToRegistrationScreen() {
        self.coordinator?.goToRegistrationScreen()
    }

    func updateEmail(to email: String) {
        self.email = email
    }

}
