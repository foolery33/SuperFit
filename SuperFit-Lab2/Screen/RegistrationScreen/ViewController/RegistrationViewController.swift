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
        viewModel.errorHandlingDelegate = self
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
    
    // MARK: - ScrollView setup
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.showsVerticalScrollIndicator = false
        return myScrollView
    }()
    private func setupScrollView() {
        view.addSubview(scrollView)
        setupContentView()
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - ContentView setup
    private lazy var contentView: UIView = {
        let myView = UIView()
        return myView
    }()
    private func setupContentView() {
        scrollView.addSubview(contentView)
        setupAppNameLabel()
        setupUserInfoStack()
        setupSignUpButton()
        setupSignInButton()
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
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
        contentView.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68)
            make.centerX.equalToSuperview()
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
        contentView.addSubview(userInfoStack)
        userInfoStack.snp.makeConstraints { make in
//            make.top.equalTo(appNameLabel.snp.bottom).offset(131)
//            make.horizontalEdges.equalToSuperview().inset(68)
            make.top.greaterThanOrEqualTo(appNameLabel.snp.bottom).offset(20)
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(68)
        }
    }
    
    // MARK: - SignUpButton setup
    private lazy var signUpButton: ButtonWithArrowStackView = {
        let myButton = ButtonWithArrowStackView(labelText: R.string.registerScreenStrings.sign_up(), arrowImage: R.image.forwardArrow()!, action: onSignUpButtonClicked)
        return myButton
    }()
    @objc private func onSignUpButtonClicked() {
        register()
    }
    private func setupSignUpButton() {
        contentView.addSubview(signUpButton)
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
        contentView.addSubview(signInButton)
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(userInfoStack.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualTo(signInButton.snp.top).offset(-37)
        }
        
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-view.safeAreaInsets.bottom).offset(-36)
            make.top.greaterThanOrEqualTo(signUpButton.snp.bottom).offset(37)
        }
    }

}

// MARK: - RegistrationTextFieldsChangeProtocol
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

// MARK: - ErrorHandlingDelegate
extension RegistrationViewController: ErrorHandlingDelegate {
    func handleErrorMessage(_ errorMessage: String) {
        DispatchQueue.main.async {
            if errorMessage == R.string.errors.unauthorized() {
                self.showAlert(title: R.string.errors.error(), message: errorMessage) {
                    self.reauthorizeUser()
                }
            }
            else {
                self.showAlert(title: R.string.errors.error(), message: errorMessage)
            }
        }
    }
    
    func reauthorizeUser() {
        
    }
}

// MARK: - Network requests
extension RegistrationViewController {
    func register() {
        view.setupActivityIndicator()
        Task {
            if await viewModel.register() {
                if await viewModel.login() {
                    viewModel.goToMainScreen()
                }
            }
            view.stopActivityIndicator()
        }
    }
}
