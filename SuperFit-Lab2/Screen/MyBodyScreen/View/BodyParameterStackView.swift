//
//  BodyParameterStackView.swift
//  SuperFit-Lab2
//
//  Created by admin on 13.05.2023.
//

import UIKit

class BodyParameterStackView: UIStackView {

    private let parameterText: String

    init(parameterText: String) {
        self.parameterText = parameterText
        super.init(frame: .zero)
        setupStackView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureBodyParameter(set value: String) {
        parameterLabel.text = value
    }

    private func setupStackView() {
        self.axis = .vertical
        self.spacing = 13
        self.alignment = .center
        setupParameterLabel()
        setupParameterEditLabel()
    }

    // MARK: - HeightLabel setup
    private lazy var parameterLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = parameterText
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.montserratBold(size: 36)
        return myLabel
    }()
    private func setupParameterLabel() {
        self.addArrangedSubview(parameterLabel)
    }

    // MARK: - WeightEditLabel setup
    private lazy var parameterEditLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = R.font.montserratRegular(size: 12)
        myLabel.text = "Edit"
        myLabel.textColor = R.color.gray()
        return myLabel
    }()
    private func setupParameterEditLabel() {
        self.addArrangedSubview(parameterEditLabel)
    }
}
