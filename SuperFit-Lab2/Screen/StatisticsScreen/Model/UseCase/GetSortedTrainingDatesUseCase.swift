//
//  GetFirstDateOfTrainingUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 26.06.2023.
//

import Foundation

final class GetSortedTrainingDatesUseCase {
    
    func getSortedDates(of trainingTypeModel: TrainingTypeModel, from trainingList: [TrainingModel]) -> [String]? {
        var dates: [Date] = []
        let filteredTrainingList = trainingList.filter { $0.exercise == trainingTypeModel }
        
        for training in filteredTrainingList {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dates.append(dateFormatter.date(from: training.date) ?? Date())
        }
        
        let sortedDates = Array(Set(dates)).sorted { $0 < $1}
        
        var sortedFormattedDates: [String] = []
        
        for date in sortedDates {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            sortedFormattedDates.append(dateFormatter.string(from: date))
        }
        
        return sortedFormattedDates.count > 0 ? sortedFormattedDates : nil
    }
    
}
