//
//  TrainingTagView.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 27.06.2023.
//

import UIKit

final class TrainingTagView: UIView {
    
    private var trainingName: String
    private(set) var trainingType: TrainingTypeModel
    var trainingTagState: TrainingTagState {
        didSet {
            if trainingTagState != oldValue {
                configureAppearance()
            }
        }
    }
    
    init(trainingName: String, trainingType: TrainingTypeModel, trainingTagState: TrainingTagState) {
        self.trainingName = trainingName
        self.trainingType = trainingType
        self.trainingTagState = trainingTagState
        super.init(frame: .zero)
        setupTagViewLabel()
        configureAppearance()
        layer.borderWidth = 1
        layer.cornerRadius = 14
        layer.borderColor = trainingTagState.borderColor.cgColor
        layer.masksToBounds = true
        backgroundColor = R.color.darkGray()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAppearance() {
        tagViewLabel.textColor = trainingTagState.textColor
        layer.borderColor = trainingTagState.borderColor.cgColor
    }
    
    // MARK: - TagViewLabel setup
    private lazy var tagViewLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = trainingName
        myLabel.textColor = trainingTagState.textColor
        myLabel.font = R.font.robotoRegular(size: 14)
        return myLabel
    }()
    private func setupTagViewLabel() {
        addSubview(tagViewLabel)
        tagViewLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.verticalEdges.equalToSuperview().inset(6)
        }
    }

}
