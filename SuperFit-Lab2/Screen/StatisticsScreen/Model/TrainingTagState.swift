//
//  TrainingTagState.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 27.06.2023.
//

import UIKit

enum TrainingTagState {
    case selected
    case normal
    
    var textColor: UIColor {
        switch self {
        case .normal:
            return R.color.white()!.withAlphaComponent(0.87)
        case .selected:
            return R.color.softPurple()!
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .normal:
            return R.color.white()!.withAlphaComponent(0.12)
        case .selected:
            return R.color.softPurple()!
        }
    }
}
