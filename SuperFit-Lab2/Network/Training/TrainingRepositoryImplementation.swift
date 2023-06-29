//
//  TrainingRepositoryImplementation.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import Alamofire
import Foundation

final class TrainingRepositoryImplementation: TrainingRepository {
    
    let baseURL = "http://fitness.wsmob.xyz:22169/"
    let interceptor = CustomRequestInterceptor()
    
    func getTrainingList() async throws -> [TrainingModel] {
        let url = baseURL + "api/trainings"
        let dataTask = AF.request(url, interceptor: interceptor).serializingDecodable([TrainingModel].self)
        do {
            print("Get training list status code:", await dataTask.response.response?.statusCode ?? 0)
            return try await dataTask.value
        } catch {
            let requestStatusCode = await dataTask.response.response?.statusCode
            switch requestStatusCode {
            case 200:
                throw AppError.trainingError(.modelError)
            case 400:
                throw AppError.trainingError(.problemWithExecuting)
            case 401:
                throw AppError.trainingError(.unauthorized)
            default:
                throw AppError.trainingError(.modelError)
            }
        }
    }
    
    func saveTraining(training: TrainingModel) async throws -> TrainingModel {
        let url = baseURL + "api/trainings"
        let httpParameters: TrainingParametersModel = TrainingParametersModel(date: training.date, exercise: training.exercise.rawValue, repeatCount: training.repeatCount)
        let dataTask =  AF.request(url, method: .post, parameters: httpParameters, encoder: JSONParameterEncoder.default, interceptor: self.interceptor).serializingDecodable(TrainingModel.self)
        do {
            print("Save training status code:", await dataTask.response.response?.statusCode ?? 0)
            return try await dataTask.value
        } catch {
            let requestStatusCode = await dataTask.response.response?.statusCode
            switch requestStatusCode {
            case 200:
                throw AppError.trainingError(.modelError)
            case 400:
                throw AppError.trainingError(.problemWithExecuting)
            case 401:
                throw AppError.trainingError(.unauthorized)
            default:
                throw AppError.trainingError(.modelError)
            }
        }
    }
    
    enum TrainingError: Error, LocalizedError, Identifiable {
        case unauthorized
        case problemWithExecuting
        case serverError
        case modelError
        
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
            }
        }
    }
    
}
