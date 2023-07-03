//
//  UserInfoStackView.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import UIKit

class UserInfoStackView: UIStackView {

    var delegate: RegistrationTextFieldsChangeProtocol?
    let userNameText: String
    let emailText: String
    let codeText: String
    let repeatCodeText: String

    init(userNameText: String, emailText: String, codeText: String, repeatCodeText: String) {
        self.userNameText = userNameText
        self.emailText = emailText
        self.codeText = codeText
        self.repeatCodeText = repeatCodeText
        super.init(frame: .zero)
        setupSubviews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        self.axis = .vertical
        self.spacing = 28
        self.addArrangedSubview(userNameField)
        self.addArrangedSubview(emailField)
        self.addArrangedSubview(codeField)
        self.addArrangedSubview(repeatCodeField)
    }

    // MARK: - UserNameField setup
    private lazy var userNameField: UnderlinedTextField = {
        let myTextField = UnderlinedTextField(
            currentText: self.userNameText,
            placeholderText: R.string.registerScreenStrings.username(),
            isSecured: false
        )
        myTextField.addTarget(self, action: #selector(onUserNameValueChanged), for: .editingChanged)
        return myTextField
    }()
    @objc private func onUserNameValueChanged() {
        delegate?.onUserNameValueChanged(userNameField)

    }

    // MARK: - EmailField setup
    private lazy var emailField: UnderlinedTextField = {
        let myTextField = UnderlinedTextField(
            currentText: self.emailText,
            placeholderText: R.string.registerScreenStrings.email(),
            isSecured: false
        )
        myTextField.addTarget(self, action: #selector(onEmailValueChanged), for: .editingChanged)
        return myTextField
    }()
    @objc private func onEmailValueChanged() {
        delegate?.onEmailValueChanged(emailField)
    }

    // MARK: - CodeField setup
    private lazy var codeField: UnderlinedTextField = {
        let myTextField = UnderlinedTextField(
            currentText: self.codeText,
            placeholderText: R.string.registerScreenStrings.code(),
            isSecured: true
        )
        myTextField.addTarget(self, action: #selector(onCodeValueChanged), for: .editingChanged)
        return myTextField
    }()
    @objc private func onCodeValueChanged() {
        delegate?.onCodeValueChanged(codeField)
    }

    // MARK: - RepeatCodeField setup
    private lazy var repeatCodeField: UnderlinedTextField = {
        let myTextField = UnderlinedTextField(
            currentText: self.repeatCodeText,
            placeholderText: R.string.registerScreenStrings.repeat_code(),
            isSecured: true
        )
        myTextField.addTarget(self, action: #selector(onRepeatCodeValueChanged), for: .editingChanged)
        return myTextField
    }()
    @objc private func onRepeatCodeValueChanged() {
        delegate?.onRepeatCodeValueChanged(repeatCodeField)
    }

}
