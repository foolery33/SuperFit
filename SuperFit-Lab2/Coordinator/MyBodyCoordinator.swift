//
//  MyBodyCoordinator.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit

final class MyBodyCoordinator: Coordinator {

    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    private let componentFactory = ComponentFactory()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        goToMyBodyScreen()
    }

    private func goToMyBodyScreen() {
        let component = componentFactory.getMyBodyComponent()
        component.myBodyViewModel.coordinator = self
        navigationController.pushViewController(component.myBodyViewController, animated: true)
    }

    func reauthenticateUser() {
        UserDataManagerRepositoryImplementation().clearAllData()
        if let mainCoordinator = parentCoordinator as? MainCoordinator {
            mainCoordinator.reauthenticateUser()
        }
        parentCoordinator?.childDidFinish(self)
    }

    func goToImageListScreen(profilePhotos: [ProfilePhotoModel]) {
        let imageListComponent = componentFactory.getImageListComponent()
        imageListComponent.imageListViewModel.coordinator = self
        imageListComponent.imageListViewModel.setProfilePhotos(profilePhotos)
        imageListComponent.imageListViewModel.profilePhotos = profilePhotos
        navigationController.pushViewController(imageListComponent.imageListViewController, animated: true)
    }

    func goToImageScreen(imageData: Data) {
        let imageComponent = componentFactory.getImageComponent()
        imageComponent.imageViewModel.coordinator = self
        imageComponent.imageViewModel.imageData = imageData
        navigationController.pushViewController(imageComponent.imageViewController, animated: false)
    }

    func goToTrainProgressScreen() {
        let trainProgressComponent = componentFactory.getTrainProgressComponent()
        trainProgressComponent.trainProgressViewModel.coordinator = self
        navigationController.pushViewController(trainProgressComponent.trainProgressViewController, animated: true)
    }

    func goToStatisticsScreen() {
        let statisticsComponent = componentFactory.getStatisticsComponent()
        statisticsComponent.statisticsViewModel.coordinator = self
        navigationController.pushViewController(statisticsComponent.statisticsViewController, animated: true)
    }

}
