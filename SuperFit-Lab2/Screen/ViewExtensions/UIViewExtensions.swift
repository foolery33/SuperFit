//
//  UIViewExtensions.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit

extension UIView {
    
    // MARK: Keyboard dismiss
    func addKeyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
}

extension UIView {
    func addPressedEffect() {
        // Добавляем обработчик нажатия на кнопку
        isUserInteractionEnabled = true
        addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(viewPressed)))
    }

    @objc func viewPressed() {
        self.alpha = 1
        UIView.animate(withDuration: 0.0, animations: {
            self.alpha = 0.5
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        })
    }
}
