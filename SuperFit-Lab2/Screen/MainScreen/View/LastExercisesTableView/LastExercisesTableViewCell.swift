//
//  LastExercisesTableViewCell.swift
//  SuperFit-Lab2
//
//  Created by admin on 03.05.2023.
//

import UIKit
import SnapKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class LastExercisesTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

    }

    func setup(with trainingInfoModel: TrainingInfoModel) {
        self.exerciseNameLabel.text = trainingInfoModel.name
        self.exerciseDescriptionLabel.text = trainingInfoModel.description
        self.cardImageView.image = trainingInfoModel.image

    }

    private func setupSubviews() {
        setupExerciseCardView()
        setupEmptyView()
    }

    // MARK: - ExerciseCardView setup
    private lazy var exerciseCardView: UIView = {
        let myView = UIView()
        myView.layer.cornerRadius = 8
        myView.layer.masksToBounds = true
        return myView
    }()
    private func setupExerciseCardView() {
        contentView.addSubview(exerciseCardView)
        setupCardImageView()
        setupCardDescriptionView()
        exerciseCardView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(114)
        }
    }

    // MARK: - CardImageView setup
    private lazy var cardImageView: UIImageView = {
        let myImageView = UIImageView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width / 2 - 16,
                height: 114
            )
        )
        myImageView.contentMode = .scaleAspectFill
        myImageView.clipsToBounds = true
        return myImageView
    }()
    private func setupCardImageView() {
        exerciseCardView.addSubview(cardImageView)
        cardImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 2 - 16)
            make.height.equalTo(114)
        }
    }

    // MARK: - CardDescriptionView setup
    private lazy var cardDescriptionView: UIView = {
        let myView = UIView()
        myView.backgroundColor = R.color.darkGray()
        return myView
    }()
    private func setupCardDescriptionView() {
        exerciseCardView.addSubview(cardDescriptionView)
        setupDescriptionStackView()
        cardDescriptionView.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview()
            make.leading.equalTo(cardImageView.snp.trailing)
        }
    }

    // MARK: - DescriptionStackView setup
    private lazy var descriptionStackView: UIView = {
        let myView = UIView()
        return myView
    }()
    private func setupDescriptionStackView() {
        cardDescriptionView.addSubview(descriptionStackView)
        setupExerciseNameLabel()
        setupExerciseDescriptionLabel()
        descriptionStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - ExerciseNameLabel setup
    private lazy var exerciseNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = R.color.white()
        myLabel.numberOfLines = 1
        myLabel.font = R.font.montserratBold(size: 14)
        myLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return myLabel
    }()
    private func setupExerciseNameLabel() {
        descriptionStackView.addSubview(exerciseNameLabel)
        exerciseNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }

    }

    // MARK: - ExerciseDescriptionLabel setup
    private lazy var exerciseDescriptionLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 5
        myLabel.textColor = R.color.gray()
        myLabel.font = R.font.montserratRegular(size: 12)
        myLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        return myLabel
    }()
    private func setupExerciseDescriptionLabel() {
        descriptionStackView.addSubview(exerciseDescriptionLabel)
        exerciseDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(exerciseNameLabel.snp.leading)
            make.trailing.equalTo(exerciseNameLabel.snp.trailing)
            make.top.equalTo(exerciseNameLabel.snp.bottom).offset(4)
//            make.bottom.equalToSuperview().offset(-8)
        }
    }

    // MARK: - EmptyView setup
    private lazy var emptyView: UIView = {
        let myView = UIView()
        myView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return myView
    }()
    private func setupEmptyView() {
        contentView.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(exerciseCardView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }

}

extension LastExercisesTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
