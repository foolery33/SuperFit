//
//  GetHeightValidationErrorUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 23.06.2023.
//

import Foundation

final class GetHeightValidationErrorUseCase {
    
    func getError(_ height: String) -> String? {
        let heightNumber = Int(height) ?? -1
        if Int(height) == -1 || heightNumber < 10 || heightNumber > 300 {
            return R.string.errors.height_validation_error()
        }
        return nil
    }
    
}
