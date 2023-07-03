//
//  MyBodyCardView.swift
//  SuperFit-Lab2
//
//  Created by admin on 02.05.2023.
//

import UIKit
import SkeletonView

class MyBodyCardView: UIView {

    var weight: String
    var height: String

    var goToMyBodyScreen: (() -> Void)?

    init(weight: String, height: String) {
        self.weight = weight
        self.height = height
        super.init(frame: .zero)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        isSkeletonable = true
        setupMyBodyCardView()
    }

    private func setupMyBodyCardView() {
        setupCardImageView()
        setupCardDescriptionView()
        weightLabel.showAnimatedSkeleton(usingColor: R.color.skeletonViewColor()!)
        heightLabel.showAnimatedSkeleton(usingColor: R.color.skeletonViewColor()!)
    }

    // MARK: - CardImageView setup
    private lazy var cardImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.myBody()?.resizeImage(newWidth: UIScreen.main.bounds.width / 2 - 16, newHeight: 114)
        return myImageView
    }()
    private func setupCardImageView() {
        self.addSubview(cardImageView)
        cardImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 2 - 16)
        }
    }

    // MARK: - CardDescriptionView setup
    private lazy var cardDescriptionView: UIView = {
        let myView = UIView()
        myView.backgroundColor = R.color.darkGray()
        return myView
    }()
    private func setupCardDescriptionView() {
        self.addSubview(cardDescriptionView)
        setupWeightInfoStackView()
        setupHeightInfoStackView()
        setupDetailsButtonStackView()
        cardDescriptionView.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview()
            make.leading.equalTo(cardImageView.snp.trailing)
        }
    }

    // MARK: - WeightInfoStackView setup
    private lazy var weightInfoStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 10
        return myStackView
    }()
    private func setupWeightInfoStackView() {
        cardDescriptionView.addSubview(weightInfoStackView)
        weightInfoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        setupWeightImageBoxView()
        setupWeightLabel()
    }

    // MARK: - WeightImageBoxView setup
    private lazy var weightImageBoxView: UIView = {
        let myView = UIView()
        return myView
    }()
    private func setupWeightImageBoxView() {
        weightInfoStackView.addArrangedSubview(weightImageBoxView)
        setupWeightImageView()
        weightImageBoxView.snp.makeConstraints { make in
            make.width.height.equalTo(22)
        }
    }

    // MARK: - WeightImageView setup
    private lazy var weightImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.weightIcon()
        myImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return myImageView
    }()
    private func setupWeightImageView() {
        weightImageBoxView.addSubview(weightImageView)
        weightImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // MARK: - WeightLabel setup
    private lazy var weightLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.montserratBold(size: 14)
        myLabel.text = "\(self.weight) \(R.string.mainScreenStrings.kg())"
        myLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        myLabel.isSkeletonable = true
        return myLabel
    }()
    private func setupWeightLabel() {
        weightInfoStackView.addArrangedSubview(weightLabel)
    }

    // MARK: - HeightInfoStackView setup
    private lazy var heightInfoStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 10
        return myStackView
    }()
    private func setupHeightInfoStackView() {
        cardDescriptionView.addSubview(heightInfoStackView)
        heightInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(weightInfoStackView.snp.bottom).offset(9)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        setupHeightImageBoxView()
        setupHeightLabel()
    }

    // MARK: - HeightImageBoxView setup
    private lazy var heightImageBoxView: UIView = {
        let myView = UIView()
        return myView
    }()
    private func setupHeightImageBoxView() {
        heightInfoStackView.addArrangedSubview(heightImageBoxView)
        setupHeightImageView()
        heightImageBoxView.snp.makeConstraints { make in
            make.width.height.equalTo(22)
        }
    }

    // MARK: - WeightImageView setup
    private lazy var heightImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.heightIcon()
        myImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return myImageView
    }()
    private func setupHeightImageView() {
        heightImageBoxView.addSubview(heightImageView)
        heightImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // MARK: - WeightLabel setup
    private lazy var heightLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.montserratBold(size: 14)
        myLabel.text = "\(self.height) \(R.string.mainScreenStrings.cm())"
        myLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        myLabel.isSkeletonable = true
        return myLabel
    }()
    private func setupHeightLabel() {
        heightInfoStackView.addArrangedSubview(heightLabel)
    }

    // MARK: - DetailsButtonStackView setup
    private lazy var detailsButtonStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(onDetailsButtonStackView)
            )
        )
        myStackView.isUserInteractionEnabled = true
        myStackView.axis = .horizontal
        myStackView.spacing = 3
        return myStackView
    }()
    @objc private func onDetailsButtonStackView() {
        goToMyBodyScreen?()
    }
    private func setupDetailsButtonStackView() {
        cardDescriptionView.addSubview(detailsButtonStackView)
        setupDetailsLabel()
        setupDetailsArrowImageView()
        detailsButtonStackView.snp.makeConstraints { make in
            make.leading.equalTo(13)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

    // MARK: - DetailsLabel setup
    private lazy var detailsLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.mainScreenStrings.details()
        myLabel.textColor = R.color.gray()
        myLabel.font = R.font.montserratRegular(size: 12)
        return myLabel
    }()
    private func setupDetailsLabel() {
        detailsButtonStackView.addArrangedSubview(detailsLabel)
    }

    // MARK: - DetailsArrowImageView setup
    private lazy var detailsArrowImageView: UIImageView = {
        let myImageView = UIImageView(image: R.image.detailsArrow())
        myImageView.contentMode = .center
        return myImageView
    }()
    private func setupDetailsArrowImageView() {
        detailsButtonStackView.addArrangedSubview(detailsArrowImageView)
    }

    func configure(weight: Int?, height: Int?) {
        if weight != nil {
            weightLabel.hideSkeleton()
            weightLabel.text = "\(weight!) \(R.string.mainScreenStrings.kg())"
        }
        if height != nil {
            heightLabel.hideSkeleton()
            heightLabel.text = "\(height!) \(R.string.mainScreenStrings.cm())"
        }
    }

}
