//
//  ComponentFactories.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import Foundation

final class ComponentFactory {
    
    private var mainComponent = MainComponent()
    
    func getAuthorizationComponent() -> AuthorizationComponent {
        return mainComponent.authorizationComponent
    }
    func getAuthorizationPinPanelComponent() -> AuthorizationPinPanelComponent {
        return mainComponent.authorizationPinPanelComponent
    }
    
}
