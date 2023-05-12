//
//  ExercisesDatabase.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import Foundation
import RealmSwift

final class ExercisesDatabase {
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func getAllExercises() -> [ExerciseModel] {
        return Array(realm.objects(ExerciseModel.self))
    }
    
    func getExerciseById(id: String) -> ExerciseModel? {
        return realm.object(ofType: ExerciseModel.self, forPrimaryKey: id)
    }
    
}
