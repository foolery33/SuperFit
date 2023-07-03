//
//  DateView.swift
//  SuperFit-Lab2
//
//  Created by admin on 13.05.2023.
//

import UIKit

final class DateView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with date: String) {
        beforeDateLabel.text = date
        hideSkeleton()
    }

    private func setupView() {
        backgroundColor = R.color.purple()
        layer.cornerRadius = 12
        isSkeletonable = true
        setupBeforeDateLabel()
        showAnimatedSkeleton(usingColor: R.color.skeletonViewColor()!)
    }

    private lazy var beforeDateLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.montserratRegular(size: 12)
        myLabel.text = "03.05.2003"
        myLabel.isSkeletonable = true
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
