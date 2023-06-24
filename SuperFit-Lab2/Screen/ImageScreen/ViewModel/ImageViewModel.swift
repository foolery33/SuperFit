//
//  ImageScreenViewModel.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 24.06.2023.
//

import Foundation

final class ImageViewModel {
    
    weak var coordinator: MyBodyCoordinator?
    var imageData: Data?
    
    func goBackToImageListScreen() {
        coordinator?.navigationController.popViewController(animated: false)
    }
    
}
