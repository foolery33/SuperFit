//
//  AuthRepository.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

protocol AuthRepository {
    func register(login: String, password: String, completion: @escaping (Result<Void, AppError>) -> Void)
//    func getAccessToken(login: String, password: String, completion: @escaping (Result<AccessTokenModel, AppError>) -> Void)
    func login(login: String, password: String, completion: @escaping (Result<AuthResponseModel, AppError>) -> Void)
}
