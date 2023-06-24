//
//  MyBodyViewController.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit
import SnapKit

class MyBodyViewController: UIViewController {

    var viewModel: MyBodyViewModel
    
    private let galleryButtonScale: CGFloat = 30.0
    private let betweenImagesSpacing: CGFloat = 4.0
    
    init(viewModel: MyBodyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupSubviews()
        viewModel.errorHandlingDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.darkGray()
        sendRequests()
    }

    private func setupSubviews() {
        setupScrollView()
    }
    
    // MARK: - ScrollView setup
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        return myScrollView
    }()
    private func setupScrollView() {
        view.addSubview(scrollView)
        setupContentView()
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - ContentView setup
    private lazy var contentView: UIView = {
        let myView = UIView()
        return myView
    }()
    private func setupContentView() {
        scrollView.addSubview(contentView)
        setupMyBodyLabel()
        setupBackArrowButton()
        setupBodyParametersStackView()
        setupMyProgressStackView()
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - MyBodyLabel setup
    private lazy var myBodyLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = R.font.montserratBold(size: 24)
        myLabel.textColor = R.color.white()
        myLabel.text = R.string.myBodyScreenStrings.my_body()
        return myLabel
    }()
    private func setupMyBodyLabel() {
        contentView.addSubview(myBodyLabel)
        myBodyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
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
        contentView.addSubview(backArrowButton)
        backArrowButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.centerY.equalTo(myBodyLabel.snp.centerY)
        }
    }
    
    // MARK: - BodyParametersStackView setup
    private lazy var bodyParametersStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 50
//        myStackView.distribution = .equalCentering
        return myStackView
    }()
    private func setupBodyParametersStackView() {
        contentView.addSubview(bodyParametersStackView)
        setupWeightStackView()
        setupHeightStackView()
        bodyParametersStackView.snp.makeConstraints { make in
            make.top.equalTo(myBodyLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - WeightStackView setup
    private lazy var weightStackView: BodyParameterStackView = {
        let myStackView = BodyParameterStackView(parameterText: "N/A \(R.string.myBodyScreenStrings.kg())")
        myStackView.isUserInteractionEnabled = true
        myStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChangeWeightAlert)))
        return myStackView
    }()
    @objc private func showChangeWeightAlert() {
        showTextFieldAlert(title: R.string.myBodyScreenStrings.change_your_weight(), onChangeButtonTapped: changeWeightValue(_:))
    }
    private func changeWeightValue(_ weight: String) {
        viewModel.updateWeight(with: weight)
        Task {
            if await viewModel.updateUserParameters() {
                weightStackView.configureBodyParameter(set: "\(viewModel.getWeight()) \(R.string.myBodyScreenStrings.kg())")
                heightStackView.configureBodyParameter(set: "\(viewModel.getHeight()) \(R.string.myBodyScreenStrings.cm())")
            }
        }
    }
    private func setupWeightStackView() {
        bodyParametersStackView.addArrangedSubview(weightStackView)
    }
    
    // MARK: - HeightStackView setup
    private lazy var heightStackView: BodyParameterStackView = {
        let myStackView = BodyParameterStackView(parameterText: "N/A \(R.string.myBodyScreenStrings.cm())")
        myStackView.isUserInteractionEnabled = true
        myStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChangeHeightAlert)))
        return myStackView
    }()
    @objc private func showChangeHeightAlert() {
        showTextFieldAlert(title: R.string.myBodyScreenStrings.change_your_height(), onChangeButtonTapped: changeHeightValue(_:))
    }
    private func changeHeightValue(_ height: String) {
        viewModel.updateHeight(with: height)
        Task {
            if await viewModel.updateUserParameters() {
                weightStackView.configureBodyParameter(set: "\(viewModel.getWeight()) \(R.string.myBodyScreenStrings.kg())")
                heightStackView.configureBodyParameter(set: "\(viewModel.getHeight()) \(R.string.myBodyScreenStrings.cm())")
            }
        }
    }
    private func setupHeightStackView() {
        bodyParametersStackView.addArrangedSubview(heightStackView)
    }

    // MARK: - MyProgressStackView setup
    private lazy var myProgressStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 16
        return myStackView
    }()
    private func setupMyProgressStackView() {
        contentView.addSubview(myProgressStackView)
        setupMyProgressLabel()
        setupSeeAllButton()
        setupMyProgressImagesStackView()
        setupButtonsStackView()
        myProgressStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(bodyParametersStackView.snp.bottom).offset(36)
        }
    }
    
    // MARK: - MyProgressLabel setup
    private lazy var myProgressLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.myBodyScreenStrings.my_progress()
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.montserratBold(size: 24)
        return myLabel
    }()
    private func setupMyProgressLabel() {
        myProgressStackView.addArrangedSubview(myProgressLabel)
    }
    
    // MARK: - SeeAllButton setup
    private lazy var seeAllButton: UIButton = {
        let myButton = UIButton()
        myButton.setTitle(R.string.mainScreenStrings.see_all(), for: .normal)
        myButton.setTitleColor(R.color.gray(), for: .normal)
        myButton.titleLabel?.font = R.font.montserratRegular(size: 12)
        myButton.addTarget(self, action: #selector(onSeeAllButtonTapped), for: .touchUpInside)
        return myButton
    }()
    @objc private func onSeeAllButtonTapped() {
        viewModel.goToImageListScreen()
    }
    private func setupSeeAllButton() {
        contentView.addSubview(seeAllButton)
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(myProgressLabel.snp.centerY)
        }
    }
    
    // MARK: - MyProgressImagesStackView setup
    private lazy var myProgressImagesStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = betweenImagesSpacing
        myStackView.backgroundColor = R.color.white()
        myStackView.layer.cornerRadius = 8
        myStackView.clipsToBounds = true
        return myStackView
    }()
    private func setupMyProgressImagesStackView() {
        myProgressStackView.addArrangedSubview(myProgressImagesStackView)
        setupBeforeImageView()
        setupAfterImageView()
        myProgressImagesStackView.snp.makeConstraints { make in
            make.height.equalTo(217)
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - BeforeImageView setup
    private lazy var beforeImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.myProgress1()
        myImageView.contentMode = .scaleAspectFill
        myImageView.clipsToBounds = true
        return myImageView
    }()
    private func setupBeforeImageView() {
        myProgressImagesStackView.addArrangedSubview(beforeImageView)
        setupBeforeDateView()
        beforeImageView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width / 2 - 16 - betweenImagesSpacing / 2)
        }
    }
    
    // MARK: - BeforeDateView setup
    private lazy var beforeDateView: DateView = {
        let myDateView = DateView(date: "21.04.2019")
        return myDateView
    }()
    private func setupBeforeDateView() {
        beforeImageView.addSubview(beforeDateView)
        beforeDateView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - AfterImageView setup
    private lazy var afterImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.myProgress2()
        myImageView.contentMode = .scaleAspectFill
        myImageView.isUserInteractionEnabled = true
        myImageView.clipsToBounds = true
        return myImageView
    }()
    private func setupAfterImageView() {
        myProgressImagesStackView.addArrangedSubview(afterImageView)
        setupAfterDateView()
        setupAddPhotoButton()
    }
    
    // MARK: - AfterDateView setup
    private lazy var afterDateView: DateView = {
        let myDateView = DateView(date: "03.01.2020")
        return myDateView
    }()
    private func setupAfterDateView() {
        afterImageView.addSubview(afterDateView)
        afterDateView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - AddPhotoButton setup
    private lazy var addPhotoButton: UIButton = {
        let myButton = UIButton()
        myButton.setImage(R.image.gallery(), for: .normal)
        myButton.backgroundColor = R.color.white()
        myButton.layer.cornerRadius = galleryButtonScale / 2
        myButton.clipsToBounds = true
        myButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
        return myButton
    }()
    private func setupAddPhotoButton() {
        afterImageView.addSubview(addPhotoButton)
        addPhotoButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(afterDateView.snp.centerY)
            make.width.height.equalTo(galleryButtonScale)
        }
    }
    
    // MARK: - ImagePicker setup
    private lazy var imagePicker: UIImagePickerController = {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        return vc
    }()
    @objc private func showImagePicker() {
        showAlertWithChoice()
    }
    
    // ButtonsStackView setup
    private lazy var buttonsStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 22
        return myStackView
    }()
    private func setupButtonsStackView() {
        contentView.addSubview(buttonsStackView)
        setupTrainProgressButton()
        setupStatisticsButton()
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(myProgressImagesStackView.snp.bottom).offset(34)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - TrainProgressButton setup
    private lazy var trainProgressButton: ButtonWithArrowStackView = {
        let myButton = ButtonWithArrowStackView(labelText: R.string.myBodyScreenStrings.train_progress(), arrowImage: R.image.forwardArrow()!, action: onTrainProgressButtonTapped)
        return myButton
    }()
    private func onTrainProgressButtonTapped() {
        
    }
    private func setupTrainProgressButton() {
        buttonsStackView.addArrangedSubview(trainProgressButton)
    }
    
    // MARK: - StatisticsButton setup
    private lazy var statisticsButton: ButtonWithArrowStackView = {
        let myButton = ButtonWithArrowStackView(labelText: R.string.myBodyScreenStrings.statistics(), arrowImage: R.image.forwardArrow()!, action: onStatisticsButtonTapped)
        return myButton
    }()
    private func onStatisticsButtonTapped() {
        
    }
    private func setupStatisticsButton() {
        buttonsStackView.addArrangedSubview(statisticsButton)
    }
    
}

extension MyBodyViewController {
    
    private func sendRequests() {
        Task {
            await getBodyParameters()
        }
        Task {
            await getUserPhotos()
            if viewModel.beforePhotoData != nil {
                beforeImageView.image = UIImage(data: viewModel.beforePhotoData!)
                beforeDateView.date = viewModel.convertTimestampToDdMmYyyy(viewModel.profilePhotos[0].uploaded)
            }
            if viewModel.afterPhotoData != nil {
                afterImageView.image = UIImage(data: viewModel.afterPhotoData!)
                afterDateView.date = viewModel.convertTimestampToDdMmYyyy(viewModel.profilePhotos[viewModel.profilePhotos.count - 1].uploaded)
            }
        }
    }
    
    private func getBodyParameters() async {
        if await viewModel.getUserParameters() {
            weightStackView.configureBodyParameter(set: "\(viewModel.getWeight()) \(R.string.myBodyScreenStrings.kg())")
            heightStackView.configureBodyParameter(set: "\(viewModel.getHeight()) \(R.string.myBodyScreenStrings.cm())")
        }
    }
    
    private func getUserPhotos() async {
        if await viewModel.getProfilePhotos() {
        }
    }
    
    func uploadPhoto(imageData: Data, image: UIImage) {
        viewModel.uploadPhoto(imageData: imageData) { success in
            if(success) {
                self.afterImageView.image = image
            }
        }
    }
    
}

// MARK: - ErrorHandlingDelegate
extension MyBodyViewController: ErrorHandlingDelegate {
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

extension MyBodyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        if let imageData = image.jpegData(compressionQuality: 0.1) {
            print(imageData)
            if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
                self.uploadPhoto(imageData: imageData, image: image)
            }
            else {
                self.showAlert(title: R.string.errors.avatar_setting_error(), message: R.string.errors.corrupted_file())
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func showAlertWithChoice() {
        let alert = UIAlertController(title: R.string.myBodyScreenStrings.choose_image_source(), message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: R.string.myBodyScreenStrings.camera(), style: .default, handler: { _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: R.string.myBodyScreenStrings.photo(), style: .default, handler: { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: R.string.myBodyScreenStrings.cancel(), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
