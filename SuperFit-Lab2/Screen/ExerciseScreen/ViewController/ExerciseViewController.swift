//
//  CrunchViewController.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit
import SnapKit

class ExerciseViewController: UIViewController {

    var viewModel: ExerciseViewModel
    
    private let circleScale: CGFloat = 216
    
    init(viewModel: ExerciseViewModel) {
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
        let trainingType = viewModel.getTrainingType()
        switch trainingType {
        case .pushUps:
            setupPushUps()
        case .plank:
            setupPlank()
        case .squats:
            setupSquats()
        case .crunch:
            setupCrunch()
        case .running:
            setupRunning()
        }
    }
    
    private func configureExercise(exerciseName: String, repeatLabelText: String, toDoLabelText: String) {
        exerciseLabel.text = exerciseName
        exerciseRepeatLabel.text = repeatLabelText
        exerciseToDoLabel.text = toDoLabelText
    }
    
    // MARK: - BackArrowButton setup
    private lazy var backArrowButton: UIButton = {
        let myButton = UIButton()
        myButton.tintColor = R.color.white()
        myButton.setImage(R.image.backwardArrow(), for: .normal)
        myButton.addTarget(self, action: #selector(goBackToAuthorizationScreen), for: .touchUpInside)
        return myButton
    }()
    @objc private func goBackToAuthorizationScreen() {
        viewModel.goToPreviousScreen()
    }
    private func setupBackArrowButton() {
        view.addSubview(backArrowButton)
        backArrowButton.snp.makeConstraints { make in
            make.centerY.equalTo(exerciseLabel.snp.centerY)
            make.leading.equalToSuperview().inset(25)
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
        setupExerciseRepeatInfoStackView()
        circleView.snp.makeConstraints { make in
            make.top.equalTo(exerciseLabel.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(circleScale)
        }
    }
    
    // MARK: ExerciseRepeatInfoStackView setup
    private lazy var exerciseRepeatInfoStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 0
        myStackView.alignment = .center
        return myStackView
    }()
    private func setupExerciseRepeatInfoStackView() {
        circleView.addSubview(exerciseRepeatInfoStackView)
        setupExerciseRepeatLabel()
        setupExerciseToDoLabel()
        exerciseRepeatInfoStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - ExerciseRepeatLabel setup
    private lazy var exerciseRepeatLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = R.font.montserratBold(size: 64)
        myLabel.textColor = R.color.white()
        return myLabel
    }()
    private func setupExerciseRepeatLabel() {
        exerciseRepeatInfoStackView.addArrangedSubview(exerciseRepeatLabel)
    }
    
    // MARK: - ExerciseToDoLabel setup
    private lazy var exerciseToDoLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = R.font.montserratBold(size: 16)
        myLabel.textColor = R.color.white()
        myLabel.text = "NEED TO DO"
        return myLabel
    }()
    private func setupExerciseToDoLabel() {
        exerciseRepeatInfoStackView.addArrangedSubview(exerciseToDoLabel)
    }

    // MARK: - FinishButton setup
    private lazy var finishButton: FilledButton = {
        let myButton = FilledButton(label: "Finish", backColor: R.color.purple()!, textColor: R.color.white()!)
        myButton.addTarget(self, action: #selector(onFinishButtonTapped), for: .touchUpInside)
        return myButton
    }()
    @objc private func onFinishButtonTapped() {
        
    }
    private func setupFinishButton() {
        view.addSubview(finishButton)
        finishButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
}

extension ExerciseViewController {
    private func setupPushUps() {
        setupExerciseLabel()
        setupCircleView()
        setupFinishButton()
        configureExercise(exerciseName: viewModel.exercise?.name ?? "", repeatLabelText: "25", toDoLabelText: "TIMES LEFT")
    }
    private func setupPlank() {
        setupExerciseLabel()
        setupCircleView()
        setupFinishButton()
        configureExercise(exerciseName: viewModel.exercise?.name ?? "", repeatLabelText: "54", toDoLabelText: "SECONDS LEFT")
    }
    private func setupSquats() {
        setupExerciseLabel()
        setupCircleView()
        setupBackArrowButton()
        configureExercise(exerciseName: viewModel.exercise?.name ?? "", repeatLabelText: "40", toDoLabelText: "TIMES LEFT")
    }
    private func setupCrunch() {
        setupExerciseLabel()
        setupCircleView()
        setupFinishButton()
        configureExercise(exerciseName: viewModel.exercise?.name ?? "", repeatLabelText: "25", toDoLabelText: "NEED TO DO")
    }
    private func setupRunning() {
        setupExerciseLabel()
        setupCircleView()
        setupFinishButton()
        configureExercise(exerciseName: viewModel.exercise?.name ?? "", repeatLabelText: "1500", toDoLabelText: "METERS PASSED")
    }
}
