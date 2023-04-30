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
        myLabel.text = "SuperFit"
        return myLabel
    }()
    private func setupAppNameLabel() {
        view.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
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
        let myTextField = UnderlinedTextField(currentText: self.viewModel.userName, placeholderText: "UserName", isSecured: false)
        myTextField.addTarget(self, action: #selector(onNameTextFieldValueChanged(_:)), for: .valueChanged)
        return myTextField
    }()
    @objc private func onNameTextFieldValueChanged(_ textField: UITextField) {
        self.viewModel.userName = textField.text ?? ""
    }
    private func setupUnderlinedTextField() {
        signInStackView.addArrangedSubview(underlinedTextField)
    }
    
    // MARK: - SignInButton setup
    private lazy var signInButton: ButtonWithArrowStackView = {
        let myStackView = ButtonWithArrowStackView(labelText: "Sign In", arrowImage: R.image.forwardArrow()!, action: onSignInButtonClicked)
        myStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func onSignInButtonClicked() {
        print("clicked")
    }
    private func setupSignInButton() {
        signInStackView.addArrangedSubview(signInButton)
    }
    
    // MARK: - SignUpButton setup
    private lazy var signUpButton: ButtonWithArrowStackView = {
        let myStackView = ButtonWithArrowStackView(labelText: "Sign Up", arrowImage: R.image.forwardArrow()!, action: onSignUpButtonClicked)
        myStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        myStackView.isLayoutMarginsRelativeArrangement = true
        return myStackView
    }()
    private func onSignUpButtonClicked() {
        print("clicked")
    }
    private func setupSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-49)
        }
    }

}
