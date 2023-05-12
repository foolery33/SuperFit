//
//  TrainingInfo.swift
//  SuperFit-Lab2
//
//  Created by admin on 03.05.2023.
//

import UIKit

struct TrainingInfoModel {
    
    init(name: String, description: String, image: UIImage) {
        self.name = name
        self.description = description
        self.image = image
    }
    
    var name: String
    var description: String
    var image: UIImage
    
}
