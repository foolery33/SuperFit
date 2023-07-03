//
//  ImageListViewController.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 23.06.2023.
//

import UIKit

class ImageListViewController: UIViewController {

    private let viewModel: ImageListViewModel

    init(viewModel: ImageListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.errorHandlingDelegate = self
        setupSubviews()
        loadProfileImages()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.darkGray()
    }

    private func setupSubviews() {
        setupScrollView()
        setupBackArrowButton()
    }

    // MARK: - ScrollView setup
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        return myScrollView
    }()
    private func setupScrollView() {
        view.addSubview(scrollView)
        setupContentStackView()
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

    // MARK: - ContentStackView
    private lazy var contentStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 24
        myStackView.layoutMargins = UIEdgeInsets(top: 36, left: 16, bottom: 0, right: 16)
        myStackView.isLayoutMarginsRelativeArrangement = true
        print(UIScreen.main.bounds.width)
        return myStackView
    }()
    private func setupContentStackView() {
        scrollView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
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
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(9)
        }
    }

    private func getMonthImagesStackView(monthLabelText: String) -> MonthImagesStackView {
        let myMonthImagesStackView = MonthImagesStackView(monthLabelText: monthLabelText)
        return myMonthImagesStackView
    }

}

// MARK: - ErrorHandlingDelegate
extension ImageListViewController: ErrorHandlingDelegate {
    func handleErrorMessage(_ errorMessage: String) {
        DispatchQueue.main.async {
            if errorMessage == R.string.errors.unauthorized() {
                self.showAlert(title: R.string.errors.error(), message: errorMessage) {
                    self.reauthorizeUser()
                }
            } else {
                self.showAlert(title: R.string.errors.error(), message: errorMessage)
            }
        }
    }

    func reauthorizeUser() {
        viewModel.reauthenticateUser()
    }
}

// MARK: - Network requests
extension ImageListViewController {
    func loadProfileImages() {
        Task {
            for (index, monthPhotos) in viewModel.groupedProfilePhotos.enumerated() {
                let group = DispatchGroup()
                viewModel.groupedProfilePhotosData.append([])
                let newMonthImagesStackView = MonthImagesStackView(
                    monthLabelText: viewModel.getMonthAndYearByTimeInterval(
                        monthPhotos[0].uploaded
                    )
                )
                self.contentStackView.addArrangedSubview(newMonthImagesStackView)
                for profilePhoto in monthPhotos {
                    group.enter()
                    if let imageData = await viewModel.downloadUserPhoto(photoId: profilePhoto.id) {
                        viewModel.groupedProfilePhotosData[index].append(imageData)
                        group.leave()
                    } else {
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    newMonthImagesStackView.monthImagesCollectionView.profilePhotosData =
                    self.viewModel.groupedProfilePhotosData[index]
                    newMonthImagesStackView.reloadMonthImagesCollectionView()
                    newMonthImagesStackView.monthImagesCollectionView.goToImageScreen = { [weak self] data in
                        self?.viewModel.goToImageScreen(imageData: data)
                    }
                }
            }
        }
    }
}
