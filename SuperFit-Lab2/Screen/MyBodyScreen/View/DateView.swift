//
//  DateView.swift
//  SuperFit-Lab2
//
//  Created by admin on 13.05.2023.
//

import UIKit

class DateView: UIStackView {

    var date: String {
        willSet {
            beforeDateLabel.text = newValue
        }
    }
    
    init(date: String) {
        self.date = date
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = R.color.purple()
        self.layer.cornerRadius = 12
        setupBeforeDateLabel()
    }
    
    private lazy var beforeDateLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = R.color.white()
        myLabel.text = date
        myLabel.font = R.font.montserratRegular(size: 12)
        return myLabel
    }()
    private func setupBeforeDateLabel() {
        self.addSubview(beforeDateLabel)
        beforeDateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.top.bottom.equalToSuperview().inset(4)
        }
    }

}
