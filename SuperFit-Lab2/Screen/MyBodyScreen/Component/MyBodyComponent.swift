//
//  MyBodyComponent.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit
import NeedleFoundation

protocol MyBodyComponentDependency: Dependency {
    var profileRepository: ProfileRepository { get }
    var userBodyParametersRepository: UserBodyParametersRepository { get }
    var profilePhotosRepository: ProfilePhotosRepository { get }
    var getMostRecentPhotoUseCase: GetMostRecentPhotoUseCase { get }
    var getLastestPhotoUseCase: GetLatestPhotoUseCase { get }
    var getBodyParametersValidationErrorUseCase: GetBodyParametersValidationErrorUseCase { get }
    var convertDateToYyyyMmDdUseCase: ConvertDateToYyyyMmDdUseCase { get }
    var convertTimestampToDdMmYyyyUseCase: ConvertTimestampToDdMmYyyyUseCase { get }
}

final class MyBodyComponent: Component<MyBodyComponentDependency> {
    var myBodyViewModel: MyBodyViewModel {
        shared {
            MyBodyViewModel(
                profileRepository: dependency.profileRepository,
                userBodyParametersRepository: dependency.userBodyParametersRepository,
                profilePhotosRepository: dependency.profilePhotosRepository,
                getMostRecentPhotoUseCase: dependency.getMostRecentPhotoUseCase,
                getLatestPhotoUseCase: dependency.getLastestPhotoUseCase,
                getBodyParametersValidationErrorUseCase: dependency.getBodyParametersValidationErrorUseCase,
                convertDateToYyyyMmDdUseCase: dependency.convertDateToYyyyMmDdUseCase,
                convertTimestampToDdMmYyyyUseCase: dependency.convertTimestampToDdMmYyyyUseCase
            )
        }
    }

    var myBodyViewController: UIViewController {
        return MyBodyViewController(viewModel: myBodyViewModel)
    }
}
