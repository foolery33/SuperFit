//
//  MainComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import NeedleFoundation
import UIKit

final class MainComponent: BootstrapComponent {
    
    var authorizationComponent: AuthorizationComponent {
        shared {
            AuthorizationComponent(parent: self)
        }
    }
    
}
