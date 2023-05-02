//
//  AuthorizationPinPanelViewModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import Foundation

final class AuthorizationPinPanelViewModel {
    
    weak var coordinator: AuthCoordinator?
    private var authRepository: AuthRepository
    private var saveRefreshTokenUseCase: SaveRefreshTokenUseCase
    private var saveUserEmailUseCase: SaveUserEmailUseCase
    var email: String = ""
    var code: String = ""
    
    var error: String = ""
    
    init(authRepository: AuthRepository, saveRefreshTokenUseCase: SaveRefreshTokenUseCase, saveUserEmailUseCase: SaveUserEmailUseCase) {
        self.authRepository = authRepository
        self.saveRefreshTokenUseCase = saveRefreshTokenUseCase
        self.saveUserEmailUseCase = saveUserEmailUseCase
    }
    
    func goBackToAuthorizationScreen() {
        self.coordinator?.navigationController.popViewController(animated: true)
    }
    
    func updatePinPanel(with digit: String) {
        self.code += digit
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
                self?.code = ""
                completion(false)
            }
        }
    }
    
}
