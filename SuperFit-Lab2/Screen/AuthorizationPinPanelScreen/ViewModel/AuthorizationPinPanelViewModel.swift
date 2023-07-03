//
//  AuthorizationPinPanelViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import Foundation

final class AuthorizationPinPanelViewModel {

    weak var coordinator: AuthCoordinator?
    weak var errorHandlingDelegate: ErrorHandlingDelegate?

    private let authRepository: AuthRepository
    private let saveRefreshTokenUseCase: SaveRefreshTokenUseCase
    private let saveUserEmailUseCase: SaveUserEmailUseCase

    var email: String = ""
    var code: String = ""

    init(
        authRepository: AuthRepository,
        saveRefreshTokenUseCase: SaveRefreshTokenUseCase,
        saveUserEmailUseCase: SaveUserEmailUseCase
    ) {
        self.authRepository = authRepository
        self.saveRefreshTokenUseCase = saveRefreshTokenUseCase
        self.saveUserEmailUseCase = saveUserEmailUseCase
    }

    func goToMainScreen() {
        self.coordinator?.goToMainScreen()
    }
    func goBackToAuthorizationScreen() {
        self.coordinator?.navigationController.popViewController(animated: true)
    }

    func updatePinPanel(with digit: String) {
        self.code += digit
    }

    func login() async -> Bool {
        do {
            let token = try await authRepository.login(login: email, password: code)
            saveRefreshTokenUseCase.save(token.refreshToken)
            saveUserEmailUseCase.save(email)
            return true
        } catch let error {
            if let appError = error as? AppError {
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            } else {
                errorHandlingDelegate?.handleErrorMessage(error.localizedDescription)
            }
            return false
        }
    }

}
