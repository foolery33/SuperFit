//
//  ExerciseModel.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import Foundation
import RealmSwift

final class ExerciseModel: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var exerciseDescription: String = ""
    @objc dynamic var imageName: String = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
