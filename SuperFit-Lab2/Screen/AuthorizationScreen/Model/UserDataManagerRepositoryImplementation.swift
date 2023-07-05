//
//  TokenManager.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation
import SwiftKeychainWrapper

final class UserDataManagerRepositoryImplementation: UserDataManagerRepository {

    private enum KeysName {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let email = "email"
    }

    func fetchAccessToken() -> String {
        KeychainWrapper.standard.string(forKey: KeysName.accessToken) ?? ""
    }
    func fetchRefreshToken() -> String {
        KeychainWrapper.standard.string(forKey: KeysName.refreshToken) ?? ""
    }
    func fetchEmail() -> String {
        KeychainWrapper.standard.string(forKey: KeysName.email) ?? ""
    }
    func saveAccessToken(accessToken: String) {
        KeychainWrapper.standard.set(accessToken, forKey: KeysName.accessToken)
    }
    func saveRefreshToken(refreshToken: String) {
        KeychainWrapper.standard.set(refreshToken, forKey: KeysName.refreshToken)
    }
    func saveEmail(email: String) {
        KeychainWrapper.standard.set(email, forKey: KeysName.email)
    }

    func clearAllData() {
        KeychainWrapper.standard.removeAllKeys()
    }

}
