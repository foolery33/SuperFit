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

    func register(login: String, password: String) async throws -> SimpleMessageModel {
        let url = baseURL + "api/auth/register"
        let httpParameters = [
            "login": login,
            "password": password
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let dataTask = AF.request(
            url,
            method: .post,
            parameters: httpParameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ).serializingDecodable(SimpleMessageModel.self)
        do {
            return try await dataTask.value
        } catch {
            let requestStatusCode = await dataTask.response.response?.statusCode
            switch requestStatusCode {
            case 200:
                throw AppError.authError(.modelError)
            case 400:
                throw AppError.authError(.invalidCredentials)
            case 500:
                throw AppError.authError(.serverError)
            default:
                throw AppError.authError(.unexpectedError)
            }
        }
    }

    func login(login: String, password: String) async throws -> AuthResponseModel {
        let url = baseURL + "api/auth/token"
        let httpParameters = [
            "login": login,
            "password": password
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let dataTask = AF.request(
            url,
            method: .post,
            parameters: httpParameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ).serializingDecodable(AuthResponseModel.self)
        do {
            return try await dataTask.value
        } catch {
            let requestStatusCode = await dataTask.response.response?.statusCode
            switch requestStatusCode {
            case 200:
                throw AppError.authError(.modelError)
            case 400:
                throw AppError.authError(.invalidCredentials)
            case 500:
                throw AppError.authError(.serverError)
            default:
                throw AppError.authError(.unexpectedError)
            }
        }
    }

    enum AuthError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        case serverError
        case modelError
        case unexpectedError
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
            case .unexpectedError:
                return R.string.errors.unexpected_error()
            }
        }
    }

}
