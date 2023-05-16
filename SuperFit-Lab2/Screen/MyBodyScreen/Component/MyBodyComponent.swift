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
    var getMostRecentPhotoUseCase: GetMostRecentPhotoUseCase { get }
    var getLastestPhotoUseCase: GetLatestPhotoUseCase { get }
    var getLastBodyParametersUseCase: GetLastBodyParametersUseCase { get }
}

final class MyBodyComponent: Component<MyBodyComponentDependency> {
    var myBodyViewModel: MyBodyViewModel {
        shared {
            MyBodyViewModel(
                profileRepository: dependency.profileRepository,
                userBodyParametersRepository: dependency.userBodyParametersRepository,
                getMostRecentPhotoUseCase: dependency.getMostRecentPhotoUseCase,
                getLatestPhotoUseCase: dependency.getLastestPhotoUseCase,
                getLastBodyParametersUseCase: dependency.getLastBodyParametersUseCase
            )
        }
    }
    
    var myBodyViewController: UIViewController {
        return MyBodyViewController(viewModel: myBodyViewModel)
    }
}
