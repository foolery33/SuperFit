//
//  PinPanelView.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit
import SnapKit

protocol PinPanelDelegate: AnyObject {
    func onChangePinValue(newDigit: String)
    var pinValue: String { get }
}

class PinPanelView: UIView {

    weak var delegate: PinPanelDelegate?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        setupFirstDigit()
        setupSecondDigit()
        setupThirdDigit()
        setupFourthDigit()
        setupFifthDigit()
        setupSixthDigit()
        setupSeventhDigit()
        setupEightDight()
        setupNinthDigit()
    }

    func addDigitToPin(digit: String) {
        delegate?.onChangePinValue(newDigit: digit)
    }

    // MARK: - FirstDigit setup
    private lazy var firstDigit: PinDigitView = {
        let myDigit = PinDigitView(digit: "1", coordinates: (0, 0), changePositions: self.changePositions(_:))
        return myDigit
    }()
    private func setupFirstDigit() {
        addSubview(firstDigit)
        makeNewConstraints(pinDigit: firstDigit)
    }

    // MARK: - SecondDigit setup
    private lazy var secondDigit: PinDigitView = {
        return PinDigitView(digit: "2", coordinates: (0, 1), changePositions: self.changePositions(_:))
    }()
    private func setupSecondDigit() {
        addSubview(secondDigit)
        makeNewConstraints(pinDigit: secondDigit)
    }

    // MARK: - ThirdDigit setup
    private lazy var thirdDigit: PinDigitView = {
        return PinDigitView(digit: "3", coordinates: (0, 2), changePositions: self.changePositions(_:))
    }()
    private func setupThirdDigit() {
        addSubview(thirdDigit)
        makeNewConstraints(pinDigit: thirdDigit)
    }

    // MARK: - FourthDigit setup
    private lazy var fourthDigit: PinDigitView = {
        return PinDigitView(digit: "4", coordinates: (1, 0), changePositions: self.changePositions(_:))
    }()
    private func setupFourthDigit() {
        addSubview(fourthDigit)
        makeNewConstraints(pinDigit: fourthDigit)
    }

    // MARK: - FifthDigit setup
    private lazy var fifthDigit: PinDigitView = {
        return PinDigitView(digit: "5", coordinates: (1, 1), changePositions: self.changePositions(_:))
    }()
    private func setupFifthDigit() {
        addSubview(fifthDigit)
        makeNewConstraints(pinDigit: fifthDigit)
    }

    // MARK: - SixthDigit setup
    private lazy var sixthDigit: PinDigitView = {
        return PinDigitView(digit: "6", coordinates: (1, 2), changePositions: self.changePositions(_:))
    }()
    private func setupSixthDigit() {
        addSubview(sixthDigit)
        makeNewConstraints(pinDigit: sixthDigit)
    }

    // MARK: - SeventhDigit setup
    private lazy var seventhDigit: PinDigitView = {
        return PinDigitView(digit: "7", coordinates: (2, 0), changePositions: self.changePositions(_:))
    }()
    private func setupSeventhDigit() {
        addSubview(seventhDigit)
        makeNewConstraints(pinDigit: seventhDigit)
    }

    // MARK: - EightDight setup
    private lazy var eightDight: PinDigitView = {
        return PinDigitView(digit: "8", coordinates: (2, 1), changePositions: self.changePositions(_:))
    }()
    private func setupEightDight() {
        addSubview(eightDight)
        makeNewConstraints(pinDigit: eightDight)
    }

    // MARK: - NinthDigit setup
    private lazy var ninthDigit: PinDigitView = {
        return PinDigitView(digit: "9", coordinates: (2, 2), changePositions: self.changePositions(_:))
    }()
    private func setupNinthDigit() {
        addSubview(ninthDigit)
        makeNewConstraints(pinDigit: ninthDigit)
    }

    private func recalculateConstraints(pinDigit: PinDigitView) {
        pinDigit.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(pinDigit.coordinates.1 * (78 + 25))
            make.top.equalToSuperview().offset(pinDigit.coordinates.0 * (78 + 21))
            make.height.width.equalTo(78)
        }
    }
    private func makeNewConstraints(pinDigit: PinDigitView) {
        pinDigit.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(pinDigit.coordinates.1 * (78 + 25))
            make.top.equalToSuperview().offset(pinDigit.coordinates.0 * (78 + 21))
            make.height.width.equalTo(78)
        }
    }

}

extension PinPanelView {

    @objc func changePositions(_ digit: String) {
        self.addDigitToPin(digit: digit)
        if self.delegate?.pinValue.count ?? 0 < 4 {
            let tuples = generateUniqueTuples()
            for (index, subview) in self.subviews.enumerated() {
                if let pinDigit = subview as? PinDigitView {
                    pinDigit.coordinates = tuples[index]
                }
            }
            UIView.animate(withDuration: 0.5, animations: {
                self.recalculateConstraints(pinDigit: self.firstDigit)
                self.recalculateConstraints(pinDigit: self.secondDigit)
                self.recalculateConstraints(pinDigit: self.thirdDigit)
                self.recalculateConstraints(pinDigit: self.fourthDigit)
                self.recalculateConstraints(pinDigit: self.fifthDigit)
                self.recalculateConstraints(pinDigit: self.sixthDigit)
                self.recalculateConstraints(pinDigit: self.seventhDigit)
                self.recalculateConstraints(pinDigit: self.eightDight)
                self.recalculateConstraints(pinDigit: self.ninthDigit)
                self.layoutIfNeeded()
            })
        }
    }

    func generateUniqueTuples() -> [(Int, Int)] {
        var tuples: [(Int, Int)] = []
        while tuples.count < 9 {
            let newTuple = (Int.random(in: 0...2), Int.random(in: 0...2))
            if !tuples.contains(where: { $0 == newTuple }) {
                tuples.append(newTuple)
            }
        }
        return tuples
    }
}
