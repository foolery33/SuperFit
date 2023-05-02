//
//  AuthRepositoryImplementation.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation
import Alamofire

final class AuthRepositoryImplementation: AuthRepository {
    
    let baseURL = "http://fitness.wsmob.xyz:22169/"
    let interceptor = CustomRequestInterceptor()
    
    func register(login: String, password: String, completion: @escaping (Result<Void, AppError>) -> Void) {
        let url = baseURL + "api/auth/register"
        let httpParameters = [
            "login": login,
            "password": password
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default, headers: headers).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Register status code:", requestStatusCode)
            }
            switch response.result {
            case .success:
                completion(.success(()))
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 400:
                        completion(.failure(.authError(.invalidCredentials)))
                    default:
                        completion(.failure(.authError(.serverError)))
                    }
                }
            }
        }
    }
    
    func login(login: String, password: String, completion: @escaping (Result<AuthResponseModel, AppError>) -> Void) {
        let url = baseURL + "api/auth/token"
        let httpParameters = [
            "login": login,
            "password": password
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default, headers: headers).validate().responseData { response in
            if let requestStatusCode = response.response?.statusCode {
                print("Get login status code:", requestStatusCode)
            }
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(AuthResponseModel.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.authError(.modelError)))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 400, 404:
                        completion(.failure(.authError(.invalidCredentials)))
                    default:
                        completion(.failure(.authError(.serverError)))
                    }
                }
            }
        }
    }
    
    enum AuthError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        case serverError
        case modelError
        var id: String {
            self.errorDescription
        }
        var errorDescription: String {
            switch self {
            case .invalidCredentials:
                return R.string.errors.invalid_credentials()
            case .serverError:
                return R.string.errors.server_error()
            case .modelError:
                return R.string.errors.model_error()
            }
        }
    }
    
}
