//
//  RegistrationViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

final class RegistrationViewModel {
    
    weak var coordinator: AuthCoordinator?
    private var authRepository: AuthRepository
    private var saveRefreshTokenUseCase: SaveRefreshTokenUseCase
    private var saveUserEmailUseCase: SaveUserEmailUseCase
    private var getRegisterValidationErrorUseCase: GetRegisterValidationErrorUseCase
    private var codeValueChangeUseCase: CodeValueChangeUseCase
    
    var userName: String = ""
    var email: String = ""
    var code: String = ""
    var repeatCode: String = ""
    
    var error: String = ""
    
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
    
    func register(completion: @escaping (Bool) -> Void) {
        
        if let error = getRegisterValidationErrorUseCase.getValidationError(
            userName: self.userName,
            email: self.email,
            password: self.code,
            confirmPassword: self.repeatCode
        ) {
            self.error = error
            completion(false)
            return
        }
        
        authRepository.register(login: self.email, password: self.code) { [weak self] result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        authRepository.login(login: self.email, password: self.code) { [weak self] result in
            switch result {
            case .success(let token):
                self?.saveRefreshTokenUseCase.save(token.refreshToken)
                self?.saveUserEmailUseCase.save(self?.email ?? "")
                completion(true)
                break
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
    func goToAuthorizationScreen() {
        self.coordinator?.navigationController.popViewController(animated: true)
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
