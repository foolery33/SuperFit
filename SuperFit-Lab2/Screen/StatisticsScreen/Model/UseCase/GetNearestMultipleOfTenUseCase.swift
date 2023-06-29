//
//  GetNearestMultipleOfTen.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 27.06.2023.
//

import Foundation

final class GetNearestMultipleOfTenUseCase {
    
    func getNearest(number:Int, toTop: Bool) -> Int {
        if toTop {
            let roundedQuotient = Int(ceil(Double(number) / 10.0))
            let nearestMultiple = roundedQuotient * 10
            return nearestMultiple
        }
        else {
            let roundedQuotient = Int(floor(Double(number) / 10.0))
            let nearestMultiple = roundedQuotient * 10
            return nearestMultiple
        }
    }
    
}
