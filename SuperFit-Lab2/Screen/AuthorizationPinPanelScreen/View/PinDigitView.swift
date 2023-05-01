//
//  PinDigitView.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit
import SnapKit

final class PinDigitView: UIView {

    var digit: String
    var coordinates: (Int, Int)
    var changePositions: () -> ()
    
    init(digit: String, coordinates: (Int, Int), changePositions: @escaping () -> ()) {
        self.digit = digit
        self.coordinates = coordinates
        self.changePositions = changePositions
        super.init(frame: .zero)
        setupSubviews()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onSquareClicked)))
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupSquareView()
    }
    
    @objc private func onSquareClicked() {
        changePositions()
    }
    
    // MARK: - SquareView setup
    private lazy var squareView: UIView = {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 78, height: 78))
        myView.layer.borderWidth = 2
        myView.layer.cornerRadius = 10
        myView.layer.borderColor = R.color.white()?.cgColor
        return myView
    }()
    private func setupSquareView() {
        addSubview(squareView)
        setupDigitLabel()
    }
    
    // MARK: - DigitLabel setup
    private lazy var digitLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = self.digit
        myLabel.textColor = R.color.white()
        myLabel.font = R.font.montserratLight(size: 64)
        return myLabel
    }()
    private func setupDigitLabel() {
        squareView.addSubview(digitLabel)
        digitLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
