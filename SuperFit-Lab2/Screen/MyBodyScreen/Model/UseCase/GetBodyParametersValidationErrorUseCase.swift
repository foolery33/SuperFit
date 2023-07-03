//
//  GetBodyParametersValidationUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 23.06.2023.
//

import Foundation

final class GetBodyParametersValidationErrorUseCase {

    private let getEmptyBodyParametersErrorUseCase: GetEmptyBodyParametersErrorUseCase
    private let getWeightValidationErrorUseCase: GetWeightValidationErrorUseCase
    private let getHeightValidationErrorUseCase: GetHeightValidationErrorUseCase

    init(
        getEmptyBodyParametersErrorUseCase: GetEmptyBodyParametersErrorUseCase,
        getWeightValidationErrorUseCase: GetWeightValidationErrorUseCase,
        getHeightValidationErrorUseCase: GetHeightValidationErrorUseCase
    ) {
        self.getEmptyBodyParametersErrorUseCase = getEmptyBodyParametersErrorUseCase
        self.getWeightValidationErrorUseCase = getWeightValidationErrorUseCase
        self.getHeightValidationErrorUseCase = getHeightValidationErrorUseCase
    }

    func getError(weight: Int?, height: Int?) -> String? {
        if let emptyBodyParametersError = getEmptyBodyParametersErrorUseCase.getError(
            weight: weight,
            height: height
        ) {
            return emptyBodyParametersError
        }

        if let invalidWeightError = getWeightValidationErrorUseCase.getError(String(weight ?? -1)) {
            return invalidWeightError
        }

        if let invalidHeightError = getHeightValidationErrorUseCase.getError(String(height ?? -1)) {
            return invalidHeightError
        }

        return nil
    }

}
