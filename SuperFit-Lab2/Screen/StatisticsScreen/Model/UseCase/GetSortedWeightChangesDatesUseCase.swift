//
//  GetSortedWeightChangesDatesUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 27.06.2023.
//

import Foundation

final class GetSortedWeightChangesDatesUseCase {

    func getSortedDates(from weightList: [BodyParametersModel]) -> [String]? {

        var dates: [Date] = []
        for weight in weightList {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dates.append(dateFormatter.date(from: weight.date) ?? Date())
        }

        let sortedDates = dates.sorted { $0 < $1 }

        var sortedFormattedDates: [String] = []

        for date in sortedDates {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            sortedFormattedDates.append(dateFormatter.string(from: date))
        }

        return !sortedFormattedDates.isEmpty ? sortedFormattedDates : nil
    }

}
