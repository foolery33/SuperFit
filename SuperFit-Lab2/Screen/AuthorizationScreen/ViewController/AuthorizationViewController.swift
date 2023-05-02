//
//  AuthorizationViewController.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit
import SnapKit

class AuthorizationViewController: UIViewController {

    var viewModel: AuthorizationViewModel
    
    init(viewModel: AuthorizationViewModel) {
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
        setupSignInStackView()
        setupSignUpButton()
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
    
    // MARK: - SignInStackView setup
    private lazy var signInStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 2
        return myStackView
    }()
    private func setupSignInStackView() {
        view.addSubview(signInStackView)
        setupUnderlinedTextField()
        setupSignInButton()
        signInStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(60)
        }
    }
    
    // MARK: - UnderlinedTextField setup
    private lazy var underlinedTextField: UnderlinedTextField = {
        let myTextField = UnderlinedTextField(currentText: self.viewModel.email, placeholderText: R.string.loginScreenStrings.username(), isSecured: false)
        myTextField.addTarget(self, action: #selector(onEmailTextFieldValueChanged(_:)), for: .editingChanged)
        return myTextField
    }()
    @objc private func onEmailTextFieldValueChanged(_ textField: UITextField) {
        self.viewModel.email = textField.text ?? ""
    }
    private func setupUnderlinedTextField() {
        signInStackView.addArrangedSubview(underlinedTextField)
    }
    
    // MARK: - SignInButton setup
    private lazy var signInButton: ButtonWithArrowStackView = {
        let myStackView = ButtonWithArrowStackView(labelText: R.string.loginScreenStrings.sign_in(), arrowImage: R.image.forwardArrow()!, action: onSignInButtonClicked)
        myStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func onSignInButtonClicked() {
        self.viewModel.onSignInButtonClicked { success in
            if success {
                self.viewModel.goToAuthorizationPinPanelScreen()
            }
            else {
                self.showAlert(title: R.string.loginScreenStrings.login_error(), message: self.viewModel.error)
            }
        }
    }
    private func setupSignInButton() {
        signInStackView.addArrangedSubview(signInButton)
    }
    
    // MARK: - SignUpButton setup
    private lazy var signUpButton: ButtonWithArrowStackView = {
        let myStackView = ButtonWithArrowStackView(labelText: R.string.loginScreenStrings.sign_up(), arrowImage: R.image.forwardArrow()!, action: onSignUpButtonClicked)
        myStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func onSignUpButtonClicked() {
        self.viewModel.goToRegistrationScreen()
    }
    private func setupSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-49)
        }
    }

}
