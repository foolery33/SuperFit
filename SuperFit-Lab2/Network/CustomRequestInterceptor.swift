//
//  CustomRequestInterceptor.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation
import Alamofire

class CustomRequestInterceptor: RequestInterceptor {
    private let retryLimit = 2
    private let retryDelay: TimeInterval = 1
    var withHeaders: Bool = true

    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if withHeaders {
            if !UserDataManagerRepositoryImplementation().fetchAccessToken().isEmpty {
                urlRequest.setValue(
                    "Bearer \(UserDataManagerRepositoryImplementation().fetchAccessToken())",
                    forHTTPHeaderField: "Authorization"
                )
            }
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        completion(.success(urlRequest))
    }

    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = (request.task?.response as? HTTPURLResponse)?.statusCode else {
            completion(.doNotRetry)
            return
        }
        switch statusCode {
        case 401:
            refreshToken { [weak self] in
                guard let self,
                  request.retryCount < self.retryLimit else {
                // Если уже попытались повторить запрос максимальное количество раз, то прекращаем попытки
                completion(.doNotRetry)
                return
            }
                completion(.retryWithDelay(self.retryDelay))
            }
        case (501...599):
            guard request.retryCount < retryLimit else { return }
            completion(.retryWithDelay(retryDelay))
        default:
            completion(.doNotRetry)
        }
    }

    private func refreshToken(completion: @escaping (() -> Void)) {
        let body = [
            "refresh_token": UserDataManagerRepositoryImplementation().fetchRefreshToken()
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let url = "http://fitness.wsmob.xyz:22169/api/auth/token/refresh"
        AF.request(
            url,
            method: .post,
            parameters: body,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(AccessTokenModel.self, from: data)
                    UserDataManagerRepositoryImplementation().saveAccessToken(accessToken: decodedData.accessToken)
                    completion()
                } catch {
                    completion()
                    return
                }
            case .failure(_):
                completion()
                return
            }
        }
    }
}
