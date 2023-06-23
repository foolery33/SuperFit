//
//  UIViewControllerExtensions.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit

extension UIViewController {
    // MARK: - Show Alert
    func showAlert(title: String, message: String, _ action: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold), NSAttributedString.Key.foregroundColor : R.color.white()!]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular), NSAttributedString.Key.foregroundColor : R.color.white()!]), forKey: "attributedMessage")
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = R.color.uiAlertBackground()
        alert.view.tintColor = R.color.uiAlertButton()
        alert.addAction(UIAlertAction(title: R.string.loginScreenStrings.ok(), style: .default, handler: { _ in
            action?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showTextFieldAlert(title: String, onChangeButtonTapped: ((String) -> ())? = nil) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = R.color.uiAlertBackground()
        alert.addTextField { textField in
            textField.superview?.backgroundColor = R.color.uiAlertTextFieldBackground()
            textField.tintColor = R.color.uiAlertTextFieldBackground()
            textField.attributedPlaceholder = NSAttributedString(string: "New value", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular), NSAttributedString.Key.foregroundColor: R.color.uiAlertTextFieldPlaceholder()!])
            textField.textColor = R.color.white()
        }
        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold), NSAttributedString.Key.foregroundColor : R.color.white()!]), forKey: "attributedTitle")
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
        })
        let changeAction = UIAlertAction(title: "Change", style: .default, handler: { _ in
            onChangeButtonTapped?(alert.textFields?.first?.text ?? "")
        })
        alert.addAction(cancelAction)
        alert.addAction(changeAction)
        alert.view.tintColor = R.color.uiAlertButton()
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
