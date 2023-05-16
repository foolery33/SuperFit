//
//  GetLastBodyParametersUseCase.swift
//  SuperFit-Lab2
//
//  Created by admin on 16.05.2023.
//

import Foundation

final class GetLastBodyParametersUseCase {
    
    func getParameters(from bodyParameters: [BodyParametersModel]) -> BodyParametersModel? {
        return bodyParameters.sorted { (model1, model2) in
            return model1.date > model2.date
        }.first
    }
    
}
