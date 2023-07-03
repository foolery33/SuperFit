//
//  ImageListComponent.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 24.06.2023.
//

import NeedleFoundation
import UIKit

protocol ImageListComponentDependency: Dependency {
    var profileRepository: ProfileRepository { get }
    var groupPhotosByMonthUseCase: GroupPhotosByMonthUseCase { get }
    var getMonthAndYearByTimeIntervalUseCase: GetMonthAndYearByTimeIntervalUseCase { get }
}

final class ImageListComponent: Component<ImageListComponentDependency> {
    var imageListViewModel: ImageListViewModel {
        shared {
            ImageListViewModel(
                profileRepository: dependency.profileRepository,
                groupPhotosByMonthUseCase: dependency.groupPhotosByMonthUseCase,
                getMonthAndYearByTimeIntervalUseCase: dependency.getMonthAndYearByTimeIntervalUseCase
            )
        }
    }

    var imageListViewController: ImageListViewController {
        return ImageListViewController(viewModel: imageListViewModel)
    }
}
