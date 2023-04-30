//
//  UIViewControllerExtensions.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit

extension UIViewController {
    // MARK: - Show Alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.loginScreenStrings.ok(), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
