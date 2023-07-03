//
//  ImageComponent.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 24.06.2023.
//

import NeedleFoundation
import UIKit

protocol ImageComponentDependency: Dependency {

}

final class ImageComponent: Component<ImageComponentDependency> {
    var imageViewModel: ImageViewModel {
        shared {
            ImageViewModel()
        }
    }

    var imageViewController: ImageViewController {
        return ImageViewController(viewModel: imageViewModel)
    }
}
