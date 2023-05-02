//
//  PasswordValidation.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

final class CodeValidationUseCase {
    func isValidCode(_ password: String) -> Bool {
        return password != "0000"
    }
}
