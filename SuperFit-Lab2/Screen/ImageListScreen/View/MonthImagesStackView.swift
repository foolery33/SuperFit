//
//  MonthImagesStackView.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 24.06.2023.
//

import UIKit

class MonthImagesStackView: UIStackView {

    private let monthLabelText: String

    init(monthLabelText: String) {
        self.monthLabelText = monthLabelText
        super.init(frame: .zero)
        setupStackView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStackView() {
        spacing = 16
        axis = .vertical
        setupMonthImagesStackView()
    }

    private func setupMonthImagesStackView() {
        setupMonthLabel()
        setupMonthImagesCollectionView()
    }

    // MARK: - MonthLabel setup
    private lazy var monthLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = monthLabelText
        myLabel.font = R.font.montserratBold(size: 24)
        myLabel.textColor = R.color.white()
        return myLabel
    }()
    private func setupMonthLabel() {
        addArrangedSubview(monthLabel)
    }

    // MARK: - MonthImagesCollectionView setup
    var monthImagesCollectionView: MonthImagesCollectionView = {
        let myMonthImagesCollectionView = MonthImagesCollectionView()
        return myMonthImagesCollectionView
    }()
    private func setupMonthImagesCollectionView() {
        addArrangedSubview(monthImagesCollectionView)
        monthImagesCollectionView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.width * 0.278 * 2 + 8)
            make.horizontalEdges.equalToSuperview()
        }
    }
    func reloadMonthImagesCollectionView() {
        monthImagesCollectionView.reloadData()
        monthImagesCollectionView.snp.remakeConstraints { make in
            make.height.equalTo(monthImagesCollectionView.countHeight())
            make.horizontalEdges.equalToSuperview()
        }
        monthImagesCollectionView.hideSkeleton()
    }

}
