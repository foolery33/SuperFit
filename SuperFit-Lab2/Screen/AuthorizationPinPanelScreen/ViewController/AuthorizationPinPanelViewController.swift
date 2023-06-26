//
//  AuthorizationPinPanelViewController.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit
import SnapKit

final class AuthorizationPinPanelViewController: UIViewController {

    var viewModel: AuthorizationPinPanelViewModel
    
    init(viewModel: AuthorizationPinPanelViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.errorHandlingDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    private func setupSubviews() {
        setupBackgroundImageView()
        setupBackArrowButton()
        setupContentStackView()
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
    
    // MARK: - BackArrowButton setup
    private lazy var backArrowButton: UIButton = {
        let myButton = UIButton(type: .custom)
        myButton.setImage(R.image.backwardArrow(), for: .normal)
        myButton.addTarget(self, action: #selector(goBackToAuthorizationScreen), for: .touchUpInside)
        return myButton
    }()
    @objc private func goBackToAuthorizationScreen() {
        self.viewModel.goBackToAuthorizationScreen()
    }
    private func setupBackArrowButton() {
        view.addSubview(backArrowButton)
        backArrowButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.leading.equalToSuperview().inset(25)
        }
    }
    
    // MARK: - ContentStackView setup
    private lazy var contentStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.distribution = .equalSpacing
        return myStackView
    }()
    private func setupContentStackView() {
        view.addSubview(contentStackView)
        setupAppNameLabel()
        setupUserNameLabel()
        setupPinPanelView()
        contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-73)
        }
    }
    
    // MARK: - AppNameLabel setup
    private lazy var appNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.montserratBold(size: 60)
        myLabel.text = R.string.generalStrings.app_name()
        return myLabel
    }()
    private func setupAppNameLabel() {
        contentStackView.addArrangedSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - UserNameLabel setup
    private lazy var userNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.montserratRegular(size: 18)
        myLabel.textAlignment = .center
        myLabel.text = self.viewModel.email
        myLabel.numberOfLines = 1
        return myLabel
    }()
    private func setupUserNameLabel() {
        contentStackView.addArrangedSubview(userNameLabel)
    }
    
    // MARK: - PinPanelView setup
    private lazy var pinPanelView: PinPanelView = {
        let myPinPanelView = PinPanelView()
        myPinPanelView.delegate = self
        return myPinPanelView
    }()
    private func setupPinPanelView() {
        contentStackView.addArrangedSubview(pinPanelView)
        pinPanelView.snp.makeConstraints { make in
            make.width.equalTo(78 + 78 + 78 + 25 + 25)
            make.height.equalTo(78 + 78 + 78 + 21 + 21)
        }
    }
    
}

// MARK: - PinPanelDelegate
extension AuthorizationPinPanelViewController: PinPanelDelegate {
    var pinValue: String {
        get {
            viewModel.code
        }
    }
    func onChangePinValue(newDigit: String) {
        viewModel.updatePinPanel(with: newDigit)
        if viewModel.code.count == 4 {
            view.setupActivityIndicator()
            Task {
                if await viewModel.login() {
                    viewModel.goToMainScreen()
                }
                view.stopActivityIndicator()
            }
        }
    }
}

// MARK: - ErrorHandlingDelegate
extension AuthorizationPinPanelViewController: ErrorHandlingDelegate {
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
