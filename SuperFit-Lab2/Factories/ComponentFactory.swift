//
//  ComponentFactories.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import Foundation

final class ComponentFactory {
    
    private let mainComponent = MainComponent()
    
    func getAuthorizationComponent() -> AuthorizationComponent {
        return mainComponent.authorizationComponent
    }
    func getAuthorizationPinPanelComponent() -> AuthorizationPinPanelComponent {
        return mainComponent.authorizationPinPanelComponent
    }
    func getRegistrationComponent() -> RegistrationComponent {
        return mainComponent.registrationComponent
    }
    func getMainScreenComponent() -> MainScreenComponent {
        return mainComponent.mainScreenComponent
    }
    func getExercisesComponent() -> ExercisesComponent {
        return mainComponent.exercisesComponent
    }
    func getExerciseComponent() -> ExerciseComponent {
        return mainComponent.exerciseComponent
    }
    func getExerciseResultComponent() -> ExerciseResultComponent {
        return mainComponent.exerciseResultComponent
    }
    func getMyBodyComponent() -> MyBodyComponent {
        return mainComponent.myBodyComponent
    }
    
}
