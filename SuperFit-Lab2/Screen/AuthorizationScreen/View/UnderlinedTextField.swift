//
//  UnderlinedTextField.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit
import SnapKit

class UnderlinedTextField: UITextField {
    enum SystemImages {
        static let eyeSlash = "eye.slash"
        static let eye = "eye"
    }
    private enum Paddings {
        static let offset = 16.0
        static let securedTextField = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 13.0, right: 40.0)
        static let textField = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 13.0, right: 10.0)
    }
    
    private enum Scales {
        static let fontSize = 18.0
        static let passwordEyeSize = 22.0
        static let bottomLineHeight = 2.0
    }
    
    let currentText: String
    let placeholderText: String
    let isSecured: Bool
    
    init(currentText: String, placeholderText: String, isSecured: Bool) {
        self.currentText = currentText
        self.placeholderText = placeholderText
        self.isSecured = isSecured
        super.init(frame: .zero)
        setupTextField()
        setupBottomLine()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.isSecured ? Paddings.securedTextField : Paddings.textField)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.isSecured ? Paddings.securedTextField : Paddings.textField)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.isSecured ? Paddings.securedTextField : Paddings.textField)
    }
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = Paddings.offset
        let width  = Int(Scales.passwordEyeSize)
        let height = width
        let x = Int(Int(bounds.width) - Int(width) - Int(offset))
        let y = Int(self.textInputView.bounds.height / 2 - Scales.passwordEyeSize / 2)
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
    private func setupTextField() {
        
        self.text = currentText
        self.autocapitalizationType = .none
        self.textColor = R.color.white()
        self.font = R.font.montserratRegular(size: Scales.fontSize)
        self.isSecureTextEntry = self.isSecured
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholderText, attributes: [NSAttributedString.Key.foregroundColor: R.color.white()!])
        
        if(self.isSecured) {
            self.rightView = passwordEye
            self.rightViewMode = .always
            self.textContentType = .oneTimeCode
        }
        
    }
    
    // MARK: - BottomLine setup
    private lazy var bottomLine: UIView = {
        let myView = UIView()
        myView.backgroundColor = R.color.white()?.withAlphaComponent(0.48)
        return myView
    }()
    private func setupBottomLine() {
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(self.snp.bottom).offset(-10)
            make.height.equalTo(Scales.bottomLineHeight)
        }
    }
    
    // MARK: - PasswordEye setup
    private lazy var passwordEye: UIButton = {
        let eye = UIButton(type: .custom)
        eye.setImage(UIImage(systemName: SystemImages.eyeSlash)!.resizeImage(newWidth: Scales.passwordEyeSize, newHeight: Scales.passwordEyeSize).withTintColor(R.color.white()!), for: .normal)
        eye.setImage(UIImage(systemName: SystemImages.eye)!.resizeImage(newWidth: Scales.passwordEyeSize, newHeight: Scales.passwordEyeSize).withTintColor(R.color.white()!), for: .selected)
        eye.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return eye
    }()
    @objc
    func togglePasswordVisibility(_ sender: UIButton) {
        self.isSecureTextEntry.toggle()
        sender.isSelected = !sender.isSelected
    }
}
