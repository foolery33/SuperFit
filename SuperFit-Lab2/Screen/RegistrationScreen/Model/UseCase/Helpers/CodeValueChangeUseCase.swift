//
//  CodeValueChangeUseCase.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

final class CodeValueChangeUseCase {
    func getCorrectCode(from code: String) -> String {
        let numbers: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        if code.isEmpty == false {
            if code.count > 4 {
                return String(code.prefix(4))
            } else {
                if numbers.contains(code.last!) == false {
                    return String(code.prefix(code.count - 1))
                } else {
                    return code
                }
            }
        } else {
            return code
        }
    }
}
