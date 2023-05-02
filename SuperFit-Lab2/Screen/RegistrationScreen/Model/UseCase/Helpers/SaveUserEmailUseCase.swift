//
//  SaveUserEmailUseCase.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import Foundation

final class SaveUserEmailUseCase {
    
    func save(_ email: String) {
        UserDataManager().saveEmail(email: email)
    }
    
}
