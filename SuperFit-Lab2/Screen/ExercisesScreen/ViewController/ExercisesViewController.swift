//
//  ExercisesViewController.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit
import SnapKit

class ExercisesViewController: UIViewController {

    private let viewModel: ExercisesViewModel
    
    init(viewModel: ExercisesViewModel) {
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
        setupTopImageView()
        setupAppNameLabel()
        setupBackArrowButton()
        setupContentView()
    }

    // MARK: - TopImageView setup
    private lazy var topImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.superFitImage()
        myImageView.clipsToBounds = true
        return myImageView
    }()
    private func setupTopImageView() {
        view.addSubview(topImageView)
        setupAppNameLabel()
        topImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(168)
        }
    }
    
    // MARK: - AppNameLabel setup
    private lazy var appNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.generalStrings.app_name()
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.montserratBold(size: 36)
        return myLabel
    }()
    private func setupAppNameLabel() {
        topImageView.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.leading.equalToSuperview().inset(25)
        }
    }
    
    // MARK: - ContentView setup
    private lazy var contentView: UIView = {
        let myView = UIView()
        myView.backgroundColor = R.color.white()
        myView.layer.cornerRadius = 24
        myView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return myView
    }()
    private func setupContentView() {
        view.addSubview(contentView)
        setupExercisesStackView()
        contentView.snp.makeConstraints { make in
            make.top.equalTo(topImageView.snp.bottom).offset(-24)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - ExercisesStackView setup
    private lazy var exercisesStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 16
        return myStackView
    }()
    private func setupExercisesStackView() {
        contentView.addSubview(exercisesStackView)
        setupExercisesLabel()
        setupExercisesTableView()
        exercisesStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - ExercisesLabel setup
    private lazy var exercisesLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = R.font.montserratBold(size: 24)
        myLabel.textColor = R.color.black()
        myLabel.text = "Exercises"
        return myLabel
    }()
    private func setupExercisesLabel() {
        exercisesStackView.addArrangedSubview(exercisesLabel)
    }
    
    // MARK: - ExercisesTableView setup
    private lazy var exercisesTableView: ExercisesTableView = {
        let myTableView = ExercisesTableView(viewModel: viewModel)
        return myTableView
    }()
    private func setupExercisesTableView() {
        exercisesStackView.addArrangedSubview(exercisesTableView)
        exercisesTableView.snp.makeConstraints { make in
            make.height.equalTo(exercisesTableView.calculateHeight())
        }
    }
    
}
