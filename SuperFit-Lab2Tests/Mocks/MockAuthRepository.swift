//
//  MockAuthRepository.swift
//  SuperFit-Lab2Tests
//
//  Created by Nikita Usov on 30.06.2023.
//

import Foundation
@testable import SuperFit_Lab2

final class MockAuthRepository {

    var shouldReturnError = false
    var loginWasCalled = false
    var registerWasCalled = false

    enum MockAuthError: Error {
        case login
        case register
    }

    func reset() {
        shouldReturnError = false
        loginWasCalled = false
        registerWasCalled = false
    }

}

extension MockAuthRepository: AuthRepository {
    func register(login: String, password: String) async throws -> SuperFit_Lab2.SimpleMessageModel {
        registerWasCalled = true

        if shouldReturnError {
            throw MockAuthError.register
        } else {
            return SimpleMessageModel(message: "OK")
        }
    }

    func login(login: String, password: String) async throws -> SuperFit_Lab2.AuthResponseModel {
        loginWasCalled = true

        if shouldReturnError {
            throw MockAuthError.login
        } else {
            return AuthResponseModel(refreshToken: "someToken")
        }
    }
}
