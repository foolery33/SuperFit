//
//  RegistrationViewController.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import UIKit
import SnapKit

protocol RegistrationTextFieldsChangeProtocol {
    func onUserNameValueChanged(_ textField: UITextField)
    func onEmailValueChanged(_ textField: UITextField)
    func onCodeValueChanged(_ textField: UITextField)
    func onRepeatCodeValueChanged(_ textField: UITextField)
}

class RegistrationViewController: UIViewController {

    var viewModel: RegistrationViewModel
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupSubviews()
        view.addKeyboardDismiss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupSubviews() {
        setupBackgroundImageView()
        setupAppNameLabel()
        setupSignInButton()
        setupSignUpButton()
        setupScrollView()
    }
    
    // MARK: - BackgroundImageView setup
    private lazy var backgroundImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.backgroundImage()
        myImageView.contentMode = .scaleAspectFill
        return myImageView
    }()
    private func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - AppNameLabel setup
    private lazy var appNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.montserratBold(size: 64)
        myLabel.text = R.string.generalStrings.app_name()
        return myLabel
    }()
    private func setupAppNameLabel() {
        view.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - ScrollView setup
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.showsVerticalScrollIndicator = false
        return myScrollView
    }()
    private func setupScrollView() {
        view.addSubview(scrollView)
        setupUserInfoStack()
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(appNameLabel.snp.bottom).offset(131)
            make.bottom.greaterThanOrEqualTo(signUpButton.snp.top).offset(-40)
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - UserInfoStack setup
    private lazy var userInfoStack: UserInfoStackView = {
        let myStackView = UserInfoStackView(
            userNameText: self.viewModel.userName,
            emailText: self.viewModel.email,
            codeText: self.viewModel.code,
            repeatCodeText: self.viewModel.repeatCode
        )
        myStackView.delegate = self
        return myStackView
    }()
    private func setupUserInfoStack() {
        scrollView.addSubview(userInfoStack)
        userInfoStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(68)
            make.width.equalToSuperview().inset(68)
        }
    }
    
    // MARK: - SignUpButton setup
    private lazy var signUpButton: ButtonWithArrowStackView = {
        let myButton = ButtonWithArrowStackView(labelText: R.string.registerScreenStrings.sign_up(), arrowImage: R.image.forwardArrow()!, action: onSignUpButtonClicked)
        return myButton
    }()
    @objc private func onSignUpButtonClicked() {
        self.view.setupActivityIndicator()
        self.viewModel.register { success in
            self.view.stopActivityIndicator()
            if success {
                
            }
            else {
                self.showAlert(title: R.string.registerScreenStrings.register_error(), message: self.viewModel.error)
            }
        }
    }
    private func setupSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(signInButton.snp.top).offset(-110)
            make.centerX.equalToSuperview().inset(40)
        }
    }
    
    // MARK: - SignInButton setup
    private lazy var signInButton: ButtonWithArrowStackView = {
        let myButton = ButtonWithArrowStackView(labelText: R.string.registerScreenStrings.sign_in(), arrowImage: R.image.backwardArrow()!, action: onSignInButtonTapped)
        return myButton
    }()
    @objc private func onSignInButtonTapped() {
        self.viewModel.goToAuthorizationScreen()
    }
    private func setupSignInButton() {
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-70)
        }
    }

}

extension RegistrationViewController: RegistrationTextFieldsChangeProtocol {
    func onUserNameValueChanged(_ textField: UITextField) {
        self.viewModel.updateUserName(with: textField.text ?? "")
        textField.text = self.viewModel.userName
    }
    
    func onEmailValueChanged(_ textField: UITextField) {
        self.viewModel.updateEmail(with: textField.text ?? "")
        textField.text = self.viewModel.email
    }
    
    func onCodeValueChanged(_ textField: UITextField) {
        self.viewModel.updateCode(with: textField.text ?? "")
        textField.text = self.viewModel.code
    }
    
    func onRepeatCodeValueChanged(_ textField: UITextField) {
        self.viewModel.updateRepeatCode(with: textField.text ?? "")
        textField.text = self.viewModel.repeatCode
    }
}
