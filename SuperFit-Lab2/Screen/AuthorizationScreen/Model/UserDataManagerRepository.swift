//
//  UserDataManagerRepository.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 04.07.2023.
//

import Foundation

protocol UserDataManagerRepository {
    func fetchAccessToken() -> String
    func fetchRefreshToken() -> String
    func fetchEmail() -> String
    func saveAccessToken(accessToken: String)
    func saveRefreshToken(refreshToken: String)
    func saveEmail(email: String)

    func clearAllData()
}
