//
//  MainViewController.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    var viewModel: MainViewModel

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.errorHandlingDelegate = self
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadLastExercises()
        getUserParameters()
    }

    private func setupSubviews() {
        setupTopImageView()
        setupScrollView()
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

    // MARK: - ScrollView setup
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.backgroundColor = R.color.white()
        myScrollView.showsVerticalScrollIndicator = false
        myScrollView.layer.cornerRadius = 24
        myScrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return myScrollView
    }()
    private func setupScrollView() {
        view.addSubview(scrollView)
        setupContentView()
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(topImageView.snp.bottom).offset(-24)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }

    // MARK: - ContentView setup
    private lazy var contentView: UIView = {
        let myView = UIView()
        return myView
    }()
    private func setupContentView() {
        scrollView.addSubview(contentView)
        setupMyBodyStackView()
        setupLastExercisesStackView()
        setupSeeAllButton()
        setupSignOutStackView()
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
            make.width.equalToSuperview()
        }
    }

    // MARK: - MyBodyStackView setup
    private lazy var myBodyStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 16
        return myStackView
    }()
    private func setupMyBodyStackView() {
        contentView.addSubview(myBodyStackView)
        setupMyBodyLabel()
        setupMyBodyCardView()
        myBodyStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }

    // MARK: - MyBodyLabel setup
    private lazy var myBodyLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.mainScreenStrings.my_body()
        myLabel.textColor = R.color.black()
        myLabel.font = R.font.montserratBold(size: 24)
        return myLabel
    }()
    private func setupMyBodyLabel() {
        myBodyStackView.addArrangedSubview(myBodyLabel)
    }

    // MARK: - MyBodyCardView setup
    private lazy var myBodyCardView: MyBodyCardView = {
        let myBodyCardView = MyBodyCardView(
            weight: R.string.mainScreenStrings.undefined(),
            height: R.string.mainScreenStrings.undefined()
        )
        myBodyCardView.goToMyBodyScreen = goToMyBodyScreen
        myBodyCardView.isSkeletonable = true
        return myBodyCardView
    }()
    private func goToMyBodyScreen() {
        viewModel.goToMyBodyScreen()
    }
    private func setupMyBodyCardView() {
        myBodyStackView.addArrangedSubview(myBodyCardView)
    }

    // MARK: - LastExercisesStackView setup
    private lazy var lastExercisesStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 16
        return myStackView
    }()
    private func setupLastExercisesStackView() {
        contentView.addSubview(lastExercisesStackView)
        setupLastExercisesLabel()
        lastExercisesStackView.snp.makeConstraints { make in
            make.top.equalTo(myBodyCardView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }

    // MARK: - LastExercisesLabel setup
    private lazy var lastExercisesLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = R.font.montserratBold(size: 24)
        myLabel.textColor = R.color.black()
        myLabel.text = R.string.mainScreenStrings.last_exercises()
        return myLabel
    }()
    private func setupLastExercisesLabel() {
        lastExercisesStackView.addArrangedSubview(lastExercisesLabel)
    }

    // MARK: - SeeAllButton setup
    private lazy var seeAllButton: UIButton = {
        let myButton = UIButton()
        myButton.setTitle(R.string.mainScreenStrings.see_all(), for: .normal)
        myButton.setTitleColor(R.color.mediumGray(), for: .normal)
        myButton.titleLabel?.font = R.font.montserratRegular(size: 12)
        myButton.addTarget(self, action: #selector(onSeeAllButtonTapped), for: .touchUpInside)
        return myButton
    }()
    @objc private func onSeeAllButtonTapped() {
        viewModel.goToExercisesScreen()
    }
    private func setupSeeAllButton() {
        contentView.addSubview(seeAllButton)
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(lastExercisesLabel.snp.centerY)
        }
    }

    // MARK: - LastExerciseView setup
    private lazy var lastExerciseView: LastExerciseView = {
        let myView = LastExerciseView()
        return myView
    }()
    private func setupLastExerciseView(with trainingType: TrainingTypeModel) {
        lastExercisesStackView.addArrangedSubview(lastExerciseView)

        let myGestureRecognizer = ExerciseTapGestureRecognizer(
            target: self,
            action: #selector(onExerciseViewTapped(_:))
        )
        myGestureRecognizer.trainingInfo = viewModel.getTrainingInfoModel(from: trainingType)
        lastExerciseView.addGestureRecognizer(myGestureRecognizer)

        lastExerciseView.setup(with: viewModel.getTrainingInfoModel(from: trainingType))
        lastExerciseView.snp.makeConstraints { make in
            make.height.equalTo(114)
        }
    }
    @objc private func onExerciseViewTapped(_ sender: ExerciseTapGestureRecognizer) {
        viewModel.goToExerciseScreen(trainingInfo: sender.trainingInfo)
    }

    // MARK: - PreLastExerciseView setup
    private lazy var preLastExerciseView: LastExerciseView = {
        let myView = LastExerciseView()
        return myView
    }()
    private func setupPreLastExerciseView(with trainingType: TrainingTypeModel) {
        lastExercisesStackView.addArrangedSubview(preLastExerciseView)

        let myGestureRecognizer = ExerciseTapGestureRecognizer(
            target: self, action: #selector(onExerciseViewTapped(_:))
        )
        myGestureRecognizer.trainingInfo = viewModel.getTrainingInfoModel(from: trainingType)
        preLastExerciseView.addGestureRecognizer(myGestureRecognizer)

        preLastExerciseView.setup(with: viewModel.getTrainingInfoModel(from: trainingType))
        preLastExerciseView.snp.makeConstraints { make in
            make.height.equalTo(114)
        }
    }

    // MARK: - SignOutStackView setup
    private lazy var signOutStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 9
        myStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logoutUser)))
        return myStackView
    }()
    @objc private func logoutUser() {
        viewModel.goToAuthorizationScreen()
    }
    private func setupSignOutStackView() {
        contentView.addSubview(signOutStackView)
        setupSignOutArrowImageView()
        setupSignOutLabel()
        signOutStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-26)
            make.top.greaterThanOrEqualTo(lastExercisesStackView.snp.bottom).offset(16)
        }
    }

    // MARK: - SignOutArrowImageView setup
    private lazy var signOutArrowImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.backwardArrow()
        myImageView.contentMode = .center
        myImageView.tintColor = R.color.black()
        return myImageView
    }()
    private func setupSignOutArrowImageView() {
        signOutStackView.addArrangedSubview(signOutArrowImageView)
    }

    // MARK: - SignOutLabel setup
    private lazy var signOutLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.mainScreenStrings.sign_out()
        myLabel.font = R.font.montserratBold(size: 24)
        myLabel.textColor = R.color.black()
        return myLabel
    }()
    private func setupSignOutLabel() {
        signOutStackView.addArrangedSubview(signOutLabel)
    }

}

final class ExerciseTapGestureRecognizer: UITapGestureRecognizer {
    var trainingInfo: TrainingInfoModel = TrainingInfoModel(name: "", description: "", image: UIImage())
}

extension MainViewController {
    func loadLastExercises() {
        Task {
            if await self.viewModel.getLastExercises() {
                if viewModel.lastExercises.count >= 1 { setupLastExerciseView(with: viewModel.lastExercises[0]) }
                if viewModel.lastExercises.count >= 2 { setupPreLastExerciseView(with: viewModel.lastExercises[1]) }
                view.setNeedsLayout()
            }
        }
    }
    func getUserParameters() {
        Task {
            if await viewModel.getUserParameters() {
                myBodyCardView.configure(weight: viewModel.getWeight(), height: viewModel.getHeight())
            }
        }
    }
}

// MARK: - ErrorHandlingDelegate
extension MainViewController: ErrorHandlingDelegate {
    func handleErrorMessage(_ errorMessage: String) {
        DispatchQueue.main.async {
            if errorMessage == R.string.errors.unauthorized() {
                self.showAlert(title: R.string.errors.error(), message: errorMessage) {
                    self.reauthorizeUser()
                }
            }
        }
    }

    func reauthorizeUser() {
        viewModel.reauthenticateUser()
    }
}
