//
//  ExercisesComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit
import NeedleFoundation

protocol ExercisesComponentDependency: Dependency {

}

final class ExercisesComponent: Component<ExercisesComponentDependency> {
    var exercisesViewModel: ExercisesViewModel {
        shared {
            ExercisesViewModel()
        }
    }

    var exercisesViewController: UIViewController {
        return ExercisesViewController(viewModel: exercisesViewModel)
    }

}
