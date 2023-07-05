//
//  ProfileRepositoryImplementation.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import Foundation
import Alamofire

final class ProfileRepositoryImplementation: ProfileRepository {

    let baseURL = "http://fitness.wsmob.xyz:22169/"
    let interceptor = CustomRequestInterceptor()

    func getUserParameters() async throws -> [BodyParametersModel] {
        let url = baseURL + "api/profile/params/history"
        let dataTask = AF.request(url, interceptor: interceptor).serializingDecodable([BodyParametersModel].self)
        do {
            return try await dataTask.value
        } catch {
            let requestStatusCode = await dataTask.response.response?.statusCode
            switch requestStatusCode {
            case 200:
                throw AppError.profileError(.modelError)
            case 400:
                throw AppError.profileError(.problemWithExecuting)
            case 401:
                throw AppError.profileError(.unauthorized)
            default:
                throw AppError.profileError(.modelError)
            }
        }
    }

    func updateUserParameters(newParameters: BodyParametersModel) async throws -> SimpleMessageModel {
        let url = baseURL + "api/profile/params"
        let dataTask = AF.request(
            url,
            method: .post,
            parameters: newParameters,
            encoder: JSONParameterEncoder.default,
            interceptor: interceptor
        ).serializingDecodable(SimpleMessageModel.self)
        do {
            return try await dataTask.value
        } catch {
            let requestStatusCode = await dataTask.response.response?.statusCode
            switch requestStatusCode {
            case 200:
                throw AppError.profileError(.modelError)
            case 400:
                throw AppError.profileError(.problemWithExecuting)
            case 401:
                throw AppError.profileError(.unauthorized)
            default:
                throw AppError.profileError(.modelError)
            }
        }
    }

    func getProfilePhotos() async throws -> [ProfilePhotoModel] {
        let url = baseURL + "api/profile/photos"
        let dataTask = AF.request(url, interceptor: interceptor).serializingDecodable([ProfilePhotoModel].self)
        do {
            return try await dataTask.value
        } catch {
            let requestStatusCode = await dataTask.response.response?.statusCode
            switch requestStatusCode {
            case 400:
                throw AppError.profileError(.problemWithExecuting)
            case 401:
                throw AppError.profileError(.unauthorized)
            default:
                throw AppError.profileError(.serverError)
            }
        }
    }

    func downloadUserPhoto(photoId: UUID) async throws -> Data {
        let url = baseURL + "api/profile/photos/\(photoId)"
        let dataTask = AF.request(url, interceptor: interceptor).serializingData()
        do {
            return try await dataTask.value
        } catch {
            let requestStatusCode = await dataTask.response.response?.statusCode
            switch requestStatusCode {
            case 400:
                throw AppError.profileError(.problemWithExecuting)
            case 401:
                throw AppError.profileError(.unauthorized)
            case 404:
                throw AppError.profileError(.photoNotFound)
            default:
                throw AppError.profileError(.modelError)
            }
        }
    }

    func uploadPhoto(imageData: Data, completion: @escaping (Result<ProfilePhotoModel, AppError>) -> Void) {
        let url = baseURL + "api/profile/photos"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDataManagerRepositoryImplementation().fetchAccessToken())",
            "Content-type": "multipart/form-data",
            "Accept": "application/json"
        ]
        interceptor.withHeaders = false
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "file", fileName: "file.jpeg", mimeType: "image/jpeg")
        }, to: url, method: .post, headers: headers, interceptor: interceptor).validate().response { response in
            self.interceptor.withHeaders = true
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(ProfilePhotoModel.self, from: data ?? Data())
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.profileError(.modelError)))
                }
            case .failure(_):
                if let requestStatusCode = response.response?.statusCode {
                    switch requestStatusCode {
                    case 400:
                        completion(.failure(.profileError(.problemWithExecuting)))
                    case 401:
                        completion(.failure(.profileError(.unauthorized)))
                    default:
                        completion(.failure(.profileError(.serverError)))
                    }
                }
            }
        }
    }

    enum ProfileError: Error, LocalizedError, Identifiable {
        case unauthorized
        case problemWithExecuting
        case serverError
        case modelError
        case photoNotFound
        var id: String {
            self.errorDescription
        }
        var errorDescription: String {
            switch self {
            case .unauthorized:
                return R.string.errors.unauthorized()
            case .serverError:
                return R.string.errors.server_error()
            case .modelError:
                return R.string.errors.model_error()
            case .problemWithExecuting:
                return R.string.errors.problem_with_executing()
            case .photoNotFound:
                return R.string.errors.photo_not_found()
            }
        }
    }

}
