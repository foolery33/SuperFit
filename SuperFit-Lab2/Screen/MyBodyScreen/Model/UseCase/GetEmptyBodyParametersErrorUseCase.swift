//
//  GetEmptyBodyParametersErrorUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 23.06.2023.
//

import Foundation

final class GetEmptyBodyParametersErrorUseCase {

    func getError(weight: Int?, height: Int?) -> String? {
        if weight == nil {
            return R.string.errors.empty_weight()
        }
        if height == nil {
            return R.string.errors.empty_height()
        }
        return nil
    }

}
