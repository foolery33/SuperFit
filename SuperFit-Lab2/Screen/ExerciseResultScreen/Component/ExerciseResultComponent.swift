//
//  ExerciseResultComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit
import NeedleFoundation

protocol ExerciseResultComponentDependency: Dependency {
    
}

final class ExerciseResultComponent: Component<ExerciseComponentDependency> {
    var exerciseResultViewModel: ExerciseResultViewModel {
        shared {
            ExerciseResultViewModel()
        }
    }
    
    var exerciseResultViewController: UIViewController {
        ExerciseResultViewController(viewModel: exerciseResultViewModel)
    }
}
