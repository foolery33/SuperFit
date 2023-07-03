//
//  GetTrainingResultsUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 26.06.2023.
//

import Foundation

final class GetTrainingResultsUseCase {

    func getTrainingResults(trainingType: TrainingTypeModel, from trainingList: [TrainingModel]) -> [Int] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let trainingListByType = trainingList.filter { $0.exercise == trainingType }
        // Группируем тренировки по дате и выбираем наибольший repeatCount для каждой даты
        let groupedTrainings = Dictionary(grouping: trainingListByType, by: { $0.date })
            .mapValues { $0.max(by: { $0.repeatCount < $1.repeatCount }) }

        // Сортируем тренировки по дате
        let sortedTrainings = groupedTrainings.sorted { entry1, entry2 in
            guard let date1 = dateFormatter.date(from: entry1.key),
                  let date2 = dateFormatter.date(from: entry2.key) else {
                return false
            }
            return date1 < date2
        }

        // Фильтруем тренировки по типу и возвращаем repeatCount
        let trainingResults = sortedTrainings
            .filter { $0.value?.exercise == trainingType }
            .compactMap { $0.value?.repeatCount }

        return trainingResults
    }

}
