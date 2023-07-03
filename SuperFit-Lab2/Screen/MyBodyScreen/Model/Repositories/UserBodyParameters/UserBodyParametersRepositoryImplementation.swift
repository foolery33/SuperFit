//
//  UserBodyParametersManager.swift
//  SuperFit-Lab2
//
//  Created by admin on 17.05.2023.
//

import Foundation

final class UserBodyParametersRepositoryImplementation: UserBodyParametersRepository {

    private enum Parameters {
        static let weight = "WeightParameter"
        static let height = "HeightParameter"
    }

    func fetchWeight() -> Int? {
        if UserDefaults.standard.object(forKey: Parameters.weight) != nil {
            return UserDefaults.standard.integer(forKey: Parameters.weight)
        }
        return nil
    }
    func fetchHeight() -> Int? {
        if UserDefaults.standard.object(forKey: Parameters.height) != nil {
            return UserDefaults.standard.integer(forKey: Parameters.height)
        }
        return nil
    }

    func saveWeight(_ weight: Int) {
        return UserDefaults.standard.set(weight, forKey: Parameters.weight)
    }
    func saveHeight(_ height: Int) {
        return UserDefaults.standard.set(height, forKey: Parameters.height)
    }

    func clearAllData() {
        UserDefaults.standard.removeObject(forKey: Parameters.height)
        UserDefaults.standard.removeObject(forKey: Parameters.weight)
    }

}
