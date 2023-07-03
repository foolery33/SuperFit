//
//  ConvertTimestampToDdMmYyyyUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 23.06.2023.
//

import Foundation

final class ConvertTimestampToDdMmYyyyUseCase {

    func convert(_ timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }

}
