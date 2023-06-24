//
//  MonthImagesCollectionViewCell.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 23.06.2023.
//

import UIKit

final class MonthImagesCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMonthImageView()
        backgroundColor = .purple
    }

    // MARK: - MonthImageView setup
    private lazy var monthImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private func setupMonthImageView() {
        contentView.clipsToBounds = true
        contentView.addSubview(monthImageView)
        monthImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with profilePhotoData: Data) {
        monthImageView.image = UIImage(data: profilePhotoData)
    }
}

extension MonthImagesCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
