//
//  Coordinator.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit

protocol Coordinator {

    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func reauthenticateUser()

}

extension Coordinator {
    mutating func childDidFinish(_ coordinator: Coordinator) {
        for (index, child) in children.enumerated() {
            // swiftlint:disable:next for_where
            if child as AnyObject === coordinator as AnyObject {
                children.remove(at: index)
                break
            }
        }
    }
}
