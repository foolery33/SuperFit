//
//  AuthRepository.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

protocol AuthRepository {
    func register(login: String, password: String) async throws -> SimpleMessageModel
    func login(login: String, password: String) async throws -> AuthResponseModel
}
