//
//  ActivityIndicator.swift
//  SuperFit-Lab2
//
//  Created by admin on 01.05.2023.
//

import UIKit
import SnapKit

class ActivityIndicator: UIView {

    var withBackground: Bool

    init(withBackground: Bool) {
        self.withBackground = withBackground
        super.init(frame: .zero)
        self.alpha = 0.0
        if self.withBackground {
            setupBackground()
        }
        setupIndicator()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var background: UIView = {
        let background = UIView()
        background.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return background
    }()
    private func setupBackground() {
        addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        return indicator
    }()
    private func setupIndicator() {
        addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    func startAnimating() {
        indicator.startAnimating()
        UIView.animate(withDuration: 0.15) {
            self.alpha = 1.0
        }
    }

}

extension ActivityIndicator {
    func setupAnimation() {
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.startAnimating()
    }
    func stopAnimation() {
        indicator.stopAnimating()
        self.alpha = 0.0
        self.removeFromSuperview()
    }
}
