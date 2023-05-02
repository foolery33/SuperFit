//
//  PasswordsEqualityValidation.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

final class CodesEqualityValidationUseCase {
    func areEqualCodes(_ password: String, _ confirmPassword: String) -> Bool {
        return password == confirmPassword
    }
}
