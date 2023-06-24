//
//  GroupPhotosByMonthUseCase.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 24.06.2023.
//

import Foundation

final class GroupPhotosByMonthUseCase {
    
    func group(_ photos: [ProfilePhotoModel]) -> [[ProfilePhotoModel]] {
        // Создаем словарь для группировки фотографий по месяцу и году
        var groupedPhotos = [String: [ProfilePhotoModel]]()

        // Группируем фотографии по месяцу и году
        for photo in photos {
            let date = Date(timeIntervalSince1970: photo.uploaded)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM"
            let monthYear = dateFormatter.string(from: date)
            
            if var group = groupedPhotos[monthYear] {
                group.append(photo)
                groupedPhotos[monthYear] = group
            } else {
                groupedPhotos[monthYear] = [photo]
            }
        }

        // Сортируем подмассивы по возрастанию
        let sortedGroups = groupedPhotos.sorted { $0.key < $1.key }

        // Сортируем элементы в каждом подмассиве по возрастанию
        let sortedPhotos = sortedGroups.map { $0.value.sorted { $0.uploaded < $1.uploaded } }

        return sortedPhotos
    }
    
}
