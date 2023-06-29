//
//  UserBodyParametersRepository.swift
//  SuperFit-Lab2
//
//  Created by admin on 17.05.2023.
//

import Foundation

protocol UserBodyParametersRepository {
    func fetchWeight() -> Int?
    func fetchHeight() -> Int?
    func saveWeight(_ weight: Int)
    func saveHeight(_ height: Int)
    
    func clearAllData()
}
