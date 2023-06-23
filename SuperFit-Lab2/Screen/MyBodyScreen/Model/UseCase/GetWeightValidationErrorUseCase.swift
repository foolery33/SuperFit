//
//  IsValidWeightUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 23.06.2023.
//

import Foundation

final class GetWeightValidationErrorUseCase {
    
    func getError(_ weight: String) -> String? {
        let weightNumber = Int(weight) ?? -1
        if Int(weight) == -1 || weightNumber < 10 || weightNumber > 300 {
            return R.string.errors.weight_validation_error()
        }
        return nil
    }
    
}
