//
//  AppError.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

enum AppError: Error, LocalizedError, Identifiable, Equatable {
    
    case authError(AuthRepositoryImplementation.AuthError)
    case trainingError(TrainingRepositoryImplementation.TrainingError)
    case profileError(ProfileRepositoryImplementation.ProfileError)
    
    var id: String {
        self.errorDescription
    }
    var errorDescription: String {
        switch self {
        case .authError(let error):
            return error.errorDescription
        case .trainingError(let error):
            return error.errorDescription
        case .profileError(let error):
            return error.errorDescription
        }
    }
    
}
