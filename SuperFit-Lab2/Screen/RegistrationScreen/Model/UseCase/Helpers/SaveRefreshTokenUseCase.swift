//
//  RegisterUseCase.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

final class SaveRefreshTokenUseCase {
    
    func save(_ refreshToken: String) {
        UserDataManager().saveRefreshToken(refreshToken: refreshToken)
    }
    
}
