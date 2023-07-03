//
//  MonthImagesCollectionView.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 23.06.2023.
//

import UIKit
import SkeletonView

final class MonthImagesCollectionView: UICollectionView {

    var profilePhotosData: [Data]?
    var goToImageScreen: ((Data) -> Void)?

    private let imageWidth: CGFloat = UIScreen.main.bounds.width * 0.278
    private let verticalSpacing: CGFloat = 8.0

    convenience init() {
        let viewLayout = UICollectionViewFlowLayout()
        self.init(frame: .zero, collectionViewLayout: viewLayout)
        setupCollectionView()
    }

    private func setupCollectionView() {
        backgroundColor = R.color.clear()
        dataSource = self
        delegate = self
        isSkeletonable = true
        register(
            MonthImagesCollectionViewCell.self,
            forCellWithReuseIdentifier: MonthImagesCollectionViewCell.identifier
        )
        showAnimatedSkeleton(usingColor: R.color.skeletonViewColor()!)
    }

}

extension MonthImagesCollectionView: SkeletonCollectionViewDataSource {

    // MARK: - SkeletonCollectionViewDataSource

    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> SkeletonView.ReusableCellIdentifier {
        return MonthImagesCollectionViewCell.identifier
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profilePhotosData?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MonthImagesCollectionViewCell.identifier,
            for: indexPath
        ) as? MonthImagesCollectionViewCell {
            cell.setup(with: profilePhotosData?[indexPath.row] ?? Data())
            return cell
        } else {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: MonthImagesCollectionViewCell.identifier,
                for: indexPath
            )
        }

    }
}

// MARK: - UICollectionViewDelegate
extension MonthImagesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToImageScreen?(profilePhotosData?[indexPath.row] ?? Data())
    }
}

extension MonthImagesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: imageWidth, height: imageWidth)
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return verticalSpacing
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
}

extension MonthImagesCollectionView {
    func countHeight() -> CGFloat {
        let rowsCount = Int((profilePhotosData?.count ?? 0) / 3) + ((profilePhotosData?.count ?? 0) % 3 != 0 ? 1 : 0)
        let rowsHeight = CGFloat(rowsCount) * imageWidth
        let spacesHeight = CGFloat(rowsCount - 1) * verticalSpacing
        return rowsHeight + spacesHeight
    }
}
