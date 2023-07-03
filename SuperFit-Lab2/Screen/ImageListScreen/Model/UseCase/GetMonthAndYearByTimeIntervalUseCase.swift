//
//  GetMonthAndYearByTimeIntervalUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 24.06.2023.
//

import Foundation

final class GetMonthAndYearByTimeIntervalUseCase {

    func getString(_ interval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: interval)

        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM, yyyy")

        let dateString = dateFormatter.string(from: date)
        let firstCharacter = dateString.prefix(1).capitalized
        let formattedString = firstCharacter + dateString.dropFirst()
        let modifiedDateString = formattedString.replacingOccurrences(of: " ", with: ", ")

        return modifiedDateString
    }

}
