//
//  TrainProgressViewController.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 25.06.2023.
//

import UIKit

final class TrainProgressViewController: UIViewController {

    private let viewModel: TrainProgressViewModel
    
    private let bottomAreaHeight: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    private let topAreaHeight: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    
    init(viewModel: TrainProgressViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.errorHandlingDelegate = self
        setupSubviews()
        getTrainingList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.darkGray()
    }
    
    private func setupSubviews() {
        setupTrainProgress()
        setupTitle()
    }
    
    private func setupTrainProgress() {
        setupBackgroundImage()
        setupRunningProgressInfo()
        setupSquatsProgressInfo()
        setupCrunchProgressInfo()
        setupPlankProgressInfo()
        setupPushUpsProgressInfo()
    }
    
    private func setupTitle() {
        setupTrainProgressLabel()
        setupBackArrowButton()
    }
    
    // MARK: - TrainProgressLabel setup
    private lazy var trainProgressLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = R.font.montserratBold(size: 24)
        myLabel.textColor = R.color.white()
        myLabel.text = R.string.myBodyScreenStrings.my_body()
        return myLabel
    }()
    private func setupTrainProgressLabel() {
        view.addSubview(trainProgressLabel)
        trainProgressLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - BackArrowButton setup
    private lazy var backArrowButton: UIButton = {
        let myButton = UIButton()
        myButton.setImage(R.image.backwardArrow(), for: .normal)
        myButton.addTarget(self, action: #selector(onBackArrowButtonTapped), for: .touchUpInside)
        myButton.tintColor = R.color.white()
        return myButton
    }()
    @objc private func onBackArrowButtonTapped() {
        viewModel.goToPreviousScreen()
    }
    private func setupBackArrowButton() {
        view.addSubview(backArrowButton)
        backArrowButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.centerY.equalTo(trainProgressLabel.snp.centerY)
        }
    }
    
    // MARK: - BackgroundImage setup
    private lazy var backgroundImage: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.trainProgressBackground()
        myImageView.contentMode = .scaleAspectFill
        return myImageView
    }()
    private func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    private lazy var runningProgressInfo: ProgressInfoView = {
        let startPoint = CGPoint(x: UIScreen.main.bounds.width / 2.7, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height / 12)
        let myProgressInfoView = ProgressInfoView(
            startPoint: startPoint,
            middlePoint: CGPoint(x: startPoint.x + 50, y: startPoint.y - 40),
            endPoint: CGPoint(x: UIScreen.main.bounds.width - 70, y: startPoint.y - 40),
            exerciseName: R.string.trainProgressScreen.running(),
            lastTrainInfo: "N/A " + R.string.trainProgressScreen.meters(),
            progressInfo: "N/A%"
        )
        myProgressInfoView.backgroundColor = R.color.clear()
        return myProgressInfoView
    }()
    private func setupRunningProgressInfo() {
        view.addSubview(runningProgressInfo)
        runningProgressInfo.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private lazy var squatsProgressInfo: ProgressInfoView = {
        let startPoint = CGPoint(x: UIScreen.main.bounds.width / 3, y: UIScreen.main.bounds.height / 2 + UIScreen.main.bounds.height / 6 - bottomAreaHeight - topAreaHeight)
        let myProgressInfoView = ProgressInfoView(
            startPoint: startPoint,
            middlePoint: CGPoint(x: startPoint.x + 50, y: startPoint.y + 40),
            endPoint: CGPoint(x: UIScreen.main.bounds.width - 70, y: startPoint.y + 40),
            exerciseName: R.string.trainProgressScreen.squats(),
            lastTrainInfo: "N/A " + R.string.trainProgressScreen.times(),
            progressInfo: "N/A%"
        )
        myProgressInfoView.backgroundColor = R.color.clear()
        print("top area height", topAreaHeight)
        print("bottom area height", bottomAreaHeight)
        return myProgressInfoView
    }()
    private func setupSquatsProgressInfo() {
        view.addSubview(squatsProgressInfo)
        squatsProgressInfo.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private lazy var crunchProgressInfo: ProgressInfoView = {
        let startPoint = CGPoint(x: UIScreen.main.bounds.width / 4, y: UIScreen.main.bounds.height / 2 - UIScreen.main.bounds.height / 8)
        let myProgressInfoView = ProgressInfoView(
            startPoint: startPoint,
            middlePoint: CGPoint(x: startPoint.x + 60, y: UIScreen.main.bounds.height / 2 - 30),
            endPoint: CGPoint(x: UIScreen.main.bounds.width - 70, y: UIScreen.main.bounds.height / 2 - 30),
            exerciseName: R.string.trainProgressScreen.crunch(),
            lastTrainInfo: "N/A " + R.string.trainProgressScreen.times(),
            progressInfo: "N/A%"
        )
        myProgressInfoView.backgroundColor = R.color.clear()
        return myProgressInfoView
    }()
    private func setupCrunchProgressInfo() {
        view.addSubview(crunchProgressInfo)
        crunchProgressInfo.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private lazy var plankProgressInfo: ProgressInfoView = {
        let startPoint = CGPoint(x: UIScreen.main.bounds.width / 2.7, y: UIScreen.main.bounds.height / 4)
        let myProgressInfoView = ProgressInfoView(
            startPoint: startPoint,
            middlePoint: CGPoint(x: UIScreen.main.bounds.width / 4 + 60, y: startPoint.y),
            endPoint: CGPoint(x: UIScreen.main.bounds.width - 70, y: startPoint.y),
            exerciseName: R.string.trainProgressScreen.plank(),
            lastTrainInfo: "N/A " + R.string.trainProgressScreen.seconds(),
            progressInfo: "N/A%"
        )
        myProgressInfoView.backgroundColor = R.color.clear()
        return myProgressInfoView
    }()
    private func setupPlankProgressInfo() {
        view.addSubview(plankProgressInfo)
        plankProgressInfo.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private lazy var pushUpsProgressInfo: ProgressInfoView = {
        let startPoint = CGPoint(x: UIScreen.main.bounds.width / 2.5, y: UIScreen.main.bounds.height / 6)
        let myProgressInfoView = ProgressInfoView(
            startPoint: startPoint,
            middlePoint: CGPoint(x: UIScreen.main.bounds.width / 2.2, y: startPoint.y - 30),
            endPoint: CGPoint(x: UIScreen.main.bounds.width - 70, y: startPoint.y - 30),
            exerciseName: R.string.trainProgressScreen.push_ups(),
            lastTrainInfo: "N/A " + R.string.trainProgressScreen.times(),
            progressInfo: "N/A%"
        )
        myProgressInfoView.backgroundColor = R.color.clear()
        return myProgressInfoView
    }()
    private func setupPushUpsProgressInfo() {
        view.addSubview(pushUpsProgressInfo)
        pushUpsProgressInfo.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

// MARK: - ErrorHandlingDelegate
extension TrainProgressViewController: ErrorHandlingDelegate {
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
        viewModel.reauthenticateUser()
    }
}

// MARK: - Network requests
extension TrainProgressViewController {
    func getTrainingList() {
        Task {
            if await viewModel.getTrainingList() {
                pushUpsProgressInfo.configure(with: viewModel.getTrainProgressByTrainingTypeModel(.pushUps))
                plankProgressInfo.configure(with: viewModel.getTrainProgressByTrainingTypeModel(.plank))
                crunchProgressInfo.configure(with: viewModel.getTrainProgressByTrainingTypeModel(.crunch))
                squatsProgressInfo.configure(with: viewModel.getTrainProgressByTrainingTypeModel(.squats))
                runningProgressInfo.configure(with: viewModel.getTrainProgressByTrainingTypeModel(.running))
            }
        }
    }
}
