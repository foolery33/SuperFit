//
//  ExerciseResultViewController.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit
import SnapKit

enum ExerciseResult {
    case success, failure
}

class ExerciseResultViewController: UIViewController {

    var viewModel: ExerciseResultViewModel
    
    private let circleScale: CGFloat = 216.0
    
    init(viewModel: ExerciseResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.darkGray()
    }

    private func setupSubviews() {
        switch viewModel.exerciseResult ?? .success {
        case .success:
            setupSuccess()
        case .failure:
            setupFailure()
        }
    }
    
    // MARK: - ExerciseLabel setup
    private lazy var exerciseLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = R.font.montserratBold(size: 36)
        myLabel.textColor = R.color.white()
        myLabel.numberOfLines = 1
        return myLabel
    }()
    private func setupExerciseLabel() {
        view.addSubview(exerciseLabel)
        exerciseLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: CircleView setup
    private lazy var circleView: UIView = {
        let myView = UIView()
        myView.layer.cornerRadius = circleScale / 2
        myView.layer.borderColor = R.color.purple()?.cgColor
        myView.layer.borderWidth = 4
        return myView
    }()
    private func setupCircleView() {
        view.addSubview(circleView)
//        setupExerciseRepeatInfoStackView()
        circleView.snp.makeConstraints { make in
            make.top.equalTo(exerciseLabel.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(circleScale)
        }
    }
    
    // MARK: - SuccessImageView setup
    private lazy var successImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.checkmark()
        return myImageView
    }()
    private func setupSuccessImageView() {
        circleView.addSubview(successImageView)
        successImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - FailureLabel setup
    private lazy var failureLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 5
        myLabel.text = "20 times are missing. You can do it better!"
        myLabel.textAlignment = .center
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.montserratBold(size: 24)
        return myLabel
    }()
    private func setupFailureLabel() {
        circleView.addSubview(failureLabel)
        failureLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(38)
        }
    }
    
    // MARK: - GoHomeButton setup
    private lazy var goHomeButton: FilledButton = {
        let myButton = FilledButton(label: "Go home", backColor: R.color.purple()!, textColor: R.color.white()!)
        return myButton
    }()
    private func setupGoHomeButton() {
        view.addSubview(goHomeButton)
        goHomeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(25)
        }
    }
    
}

extension ExerciseResultViewController {
    private func setupSuccess() {
        setupExerciseLabel()
        exerciseLabel.text = viewModel.exercise?.name ?? ""
        setupCircleView()
        setupSuccessImageView()
        setupGoHomeButton()
    }
    private func setupFailure() {
        setupExerciseLabel()
        exerciseLabel.text = viewModel.exercise?.name ?? ""
        setupCircleView()
        setupFailureLabel()
        setupGoHomeButton()
    }
}
