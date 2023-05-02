//
//  GetValidationErrorUseCase.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

final class GetRegisterValidationErrorUseCase {
    
    var emptyValidationUseCase: EmptyValidationUseCase
    var emailValidationUseCase: EmailValidationUseCase
    var codesEqualityValidationUseCase: CodesEqualityValidationUseCase
    var codeValidationUseCase: CodeValidationUseCase
    
    init(emptyValidationUseCase: EmptyValidationUseCase, emailValidationUseCase: EmailValidationUseCase, codesEqualityValidationUseCase: CodesEqualityValidationUseCase, codeValidationUseCase: CodeValidationUseCase) {
        self.emptyValidationUseCase = emptyValidationUseCase
        self.emailValidationUseCase = emailValidationUseCase
        self.codesEqualityValidationUseCase = codesEqualityValidationUseCase
        self.codeValidationUseCase = codeValidationUseCase
    }
    
    func getValidationError(userName: String, email: String, password: String, confirmPassword: String) -> String? {
        if emptyValidationUseCase.isEmptyField(userName) {
            return R.string.errors.empty_username()
        }
        if emptyValidationUseCase.isEmptyField(email) {
            return R.string.errors.empty_email()
        }
        if emptyValidationUseCase.isEmptyField(password) {
            return R.string.errors.empty_code()
        }
        if emptyValidationUseCase.isEmptyField(confirmPassword) {
            return R.string.errors.empty_repeat_code()
        }
        if emailValidationUseCase.isValidEmail(email) == false {
            return R.string.errors.invalid_email()
        }
        if codesEqualityValidationUseCase.areEqualCodes(password, confirmPassword) == false {
            return R.string.errors.different_codes()
        }
        if codeValidationUseCase.isValidCode(password) == false {
            return R.string.errors.invalid_code()
        }
        return nil
    }
}
