//
//  ButtonWithArrowStackView.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit

class ButtonWithArrowStackView: UIStackView {

    var labelText: String
    var arrowImage: UIImage
    var action: () -> ()
    
    init(labelText: String, arrowImage: UIImage, action: @escaping () -> ()) {
        self.labelText = labelText
        self.arrowImage = arrowImage
        self.action = action
        super.init(frame: .zero)
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        self.axis = .horizontal
        self.spacing = 8
        self.alignment = .center
        setupSubStackView()
        self.addArrangedSubview(spacerView)
    }
    
    private lazy var subStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.addPressedEffect()
        myStackView.axis = .horizontal
        myStackView.spacing = 8
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onStackViewClicked))
        myStackView.addGestureRecognizer(tapGestureRecognizer)
        myStackView.isUserInteractionEnabled = true
        return myStackView
    }()
    @objc private func onStackViewClicked() {
        action()
        self.viewPressed()
    }
    private func setupSubStackView() {
        self.addArrangedSubview(subStackView)
        subStackView.addArrangedSubview(buttonLabel)
        subStackView.addArrangedSubview(arrowImageView)
    }
    
    // MARK: - ButtonLabel setup
    private lazy var buttonLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = self.labelText
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.montserratBold(size: 24)
        return myLabel
    }()
    private func setupButtonLabel() {
        addSubview(buttonLabel)
        buttonLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
        }
    }
    
    // MARK: - ArrowImageView setup
    private lazy var arrowImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = self.arrowImage
        myImageView.contentMode = .scaleAspectFit
        myImageView.tintColor = R.color.white()
        return myImageView
    }()
    
    // MARK: - SpacerView setup
    private lazy var spacerView: UIView = {
        let myView = UIView()
        return myView
    }()
    
}
