//
//  GetWeightChangesUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 26.06.2023.
//

import Foundation

final class GetWeightChangesUseCase {
    
    func getChanges(bodyParameters: [BodyParametersModel]) -> [Int] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let sortedBodyParameters = bodyParameters.sorted { bodyParameter1, bodyParameter2 in
            guard let date1 = dateFormatter.date(from: bodyParameter1.date),
                  let date2 = dateFormatter.date(from: bodyParameter2.date) else {
                return false
            }
            return date1 < date2
        }
        return sortedBodyParameters.map({ $0.weight })
    }
    
}
