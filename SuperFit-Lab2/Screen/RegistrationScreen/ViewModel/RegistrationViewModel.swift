//
//  RegistrationViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

final class RegistrationViewModel {
    
    weak var coordinator: AuthCoordinator?
    weak var errorHandlingDelegate: ErrorHandlingDelegate?
    
    private let authRepository: AuthRepository
    private let saveRefreshTokenUseCase: SaveRefreshTokenUseCase
    private let saveUserEmailUseCase: SaveUserEmailUseCase
    private let getRegisterValidationErrorUseCase: GetRegisterValidationErrorUseCase
    private let codeValueChangeUseCase: CodeValueChangeUseCase
    
    var userName: String = ""
    var email: String = ""
    var code: String = ""
    var repeatCode: String = ""
    
    init(authRepository: AuthRepository,
         saveRefreshTokenUseCase: SaveRefreshTokenUseCase,
         saveUserEmailUseCase: SaveUserEmailUseCase,
         getRegisterValidationErrorUseCase: GetRegisterValidationErrorUseCase,
         codeValueChangeUseCase: CodeValueChangeUseCase) {
        self.authRepository = authRepository
        self.saveRefreshTokenUseCase = saveRefreshTokenUseCase
        self.saveUserEmailUseCase = saveUserEmailUseCase
        self.getRegisterValidationErrorUseCase = getRegisterValidationErrorUseCase
        self.codeValueChangeUseCase = codeValueChangeUseCase
    }
    
    func updateUserName(with string: String) {
        self.userName = string
    }
    func updateEmail(with string: String) {
        self.email = string
    }
    func updateCode(with string: String) {
        self.code = self.codeValueChangeUseCase.getCorrectCode(from: string)
    }
    func updateRepeatCode(with string: String) {
        self.repeatCode = self.codeValueChangeUseCase.getCorrectCode(from: string)
    }
    
}

// MARK: - Navigation
extension RegistrationViewModel {
    func goToAuthorizationScreen() {
        coordinator?.navigationController.popViewController(animated: true)
    }
    
    func goToMainScreen() {
        coordinator?.goToMainScreen()
    }
}

// MARK: - Network requests
extension RegistrationViewModel {
    func register() async -> Bool {
        if let error = getRegisterValidationErrorUseCase.getValidationError(
            userName: self.userName,
            email: self.email,
            password: self.code,
            confirmPassword: self.repeatCode
        ) {
            errorHandlingDelegate?.handleErrorMessage(error)
            return false
        }
        
        do {
            _ = try await authRepository.register(login: email, password: code)
            return true
        } catch(let error) {
            if let appError = error as? AppError {
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            }
            else {
                errorHandlingDelegate?.handleErrorMessage(error.localizedDescription)
            }
            return false
        }
    }
    
    func login() async -> Bool {
        do {
            let token = try await authRepository.login(login: email, password: code)
            saveRefreshTokenUseCase.save(token.refreshToken)
            saveUserEmailUseCase.save(email)
            return true
        } catch(let error) {
            if let appError = error as? AppError {
                errorHandlingDelegate?.handleErrorMessage(appError.errorDescription)
            }
            else {
                errorHandlingDelegate?.handleErrorMessage(error.localizedDescription)
            }
            return false
        }
    }
}
