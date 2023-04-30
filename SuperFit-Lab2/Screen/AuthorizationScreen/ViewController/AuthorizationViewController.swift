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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupSubviews() {
        setupAppNameLabel()
    }
    
    // MARK: AppNameLabel setup
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

}
