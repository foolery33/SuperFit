//
//  EmptyValidationUseCase.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

final class EmptyValidationUseCase {
    func isEmptyField(_ field: String) -> Bool {
        return field.isEmpty
    }
}
