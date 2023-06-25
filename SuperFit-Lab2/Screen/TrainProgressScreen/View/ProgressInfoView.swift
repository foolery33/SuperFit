//
//  ProgressInfoView.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 25.06.2023.
//

import UIKit

final class ProgressInfoView: UIView {

    private let startPoint: CGPoint
    private let middlePoint: CGPoint
    private let endPoint: CGPoint
    private let exerciseName: String
    private let lastTrainInfo: String
    private let progressInfo: String
    
    private let circleSize: CGFloat = 8.0
    
    init(startPoint: CGPoint, middlePoint: CGPoint, endPoint: CGPoint, exerciseName: String, lastTrainInfo: String, progressInfo: String) {
        self.startPoint = startPoint
        self.middlePoint = middlePoint
        self.endPoint = endPoint
        self.exerciseName = exerciseName
        self.lastTrainInfo = lastTrainInfo
        self.progressInfo = progressInfo
        
        super.init(frame: .zero)
        
        addSubview(circleImageView)
        addSubview(exerciesNameLabel)
        
//        addSubview(progressInfoStackView)
        addSubview(lastTrainLabel)
        addSubview(progressLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        R.color.purple()!.set()
        path.lineWidth = 2
        
        path.move(to: startPoint)
        path.addLine(to: middlePoint)
        path.addLine(to: endPoint)
        
        path.stroke()
    }
    
    func configure(with trainingProgress: TrainingProgressModel?) {
        if trainingProgress != nil {
            let lastTrainLabelAttributedString = NSMutableAttributedString(string: "\(R.string.trainProgressScreen.last_train()) ", attributes: [NSAttributedString.Key.foregroundColor: R.color.white()!, NSAttributedString.Key.font: R.font.montserratRegular(size: 12)!])
            lastTrainLabelAttributedString.append(NSAttributedString(string: trainingProgress!.lastTrain, attributes: [NSAttributedString.Key.foregroundColor: R.color.white()!, NSAttributedString.Key.font: R.font.montserratBold(size: 12)!]))
            lastTrainLabel.attributedText = lastTrainLabelAttributedString
            lastTrainLabel.adjustsFontSizeToFitWidth = true
            lastTrainLabel.sizeToFit()
            
            let progressLabelAttributedString = NSMutableAttributedString(string: "\(R.string.trainProgressScreen.last_train()) ", attributes: [NSAttributedString.Key.foregroundColor: R.color.white()!, NSAttributedString.Key.font: R.font.montserratRegular(size: 12)!])
            progressLabelAttributedString.append(NSAttributedString(string: (trainingProgress!.progress.count > 0) ? trainingProgress!.progress : "N/A%", attributes: [NSAttributedString.Key.foregroundColor: R.color.white()!, NSAttributedString.Key.font: R.font.montserratBold(size: 12)!]))
            progressLabel.attributedText = progressLabelAttributedString
            progressLabel.adjustsFontSizeToFitWidth = true
            progressLabel.sizeToFit()
            if trainingProgress?.progress.count != 0 {
                if trainingProgress!.progress.first! == "-" {
                    progressArrowImageView.image = R.image.redArrowDown()
                    addSubview(progressArrowImageView)
                }
                else {
                    progressArrowImageView.image = R.image.greenArrowUp()
                    addSubview(progressArrowImageView)
                }
            }
        }
    }

    // MARK: - CircleImage setup
    private lazy var circleImageView: UIImageView = {
        let myImageView = UIImageView(frame: CGRect(origin: circlePoint, size: CGSize(width: circleSize, height: circleSize)))
        myImageView.image = R.image.trainProgressCircle()
        return myImageView
    }()
    
    // MARK: - ExerciseNameLabel setup
    private lazy var exerciesNameLabel: UILabel = {
        let myLabel = UILabel(frame: CGRect(x: middlePoint.x + 10, y: middlePoint.y - 25, width: 200, height: 100))
        myLabel.text = exerciseName
        myLabel.adjustsFontSizeToFitWidth = true
        myLabel.sizeToFit()
        myLabel.textColor = R.color.white()
        myLabel.numberOfLines = 1
        myLabel.font = R.font.montserratBold(size: 14)
        return myLabel
    }()
    
    // MARK: - LastTrainLabel setup
    private lazy var lastTrainLabel: UILabel = {
        let myLabel = UILabel(frame: CGRect(x: middlePoint.x + 10, y: middlePoint.y + 9, width: 200, height: 100))
        let attributedString = NSMutableAttributedString(string: "\(R.string.trainProgressScreen.last_train()) ", attributes: [NSAttributedString.Key.foregroundColor: R.color.white()!, NSAttributedString.Key.font: R.font.montserratRegular(size: 12)!])
        attributedString.append(NSAttributedString(string: lastTrainInfo, attributes: [NSAttributedString.Key.foregroundColor: R.color.white()!, NSAttributedString.Key.font: R.font.montserratBold(size: 12)!]))
        myLabel.attributedText = attributedString
        myLabel.adjustsFontSizeToFitWidth = true
        myLabel.sizeToFit()
        return myLabel
    }()
    
    // MARK: - ProgressLabel setup
    private lazy var progressLabel: UILabel = {
        let myLabel = UILabel(frame: CGRect(x: lastTrainLabel.frame.minX, y: lastTrainLabel.frame.maxY + 5, width: 200, height: 100))
        let attributedString = NSMutableAttributedString(string: "\(R.string.trainProgressScreen.progress()) ", attributes: [NSAttributedString.Key.foregroundColor: R.color.white()!, NSAttributedString.Key.font: R.font.montserratRegular(size: 12)!])
        attributedString.append(NSAttributedString(string: progressInfo, attributes: [NSAttributedString.Key.foregroundColor: R.color.white()!, NSAttributedString.Key.font: R.font.montserratBold(size: 12)!]))
        myLabel.attributedText = attributedString
        myLabel.adjustsFontSizeToFitWidth = true
        myLabel.sizeToFit()
        return myLabel
    }()
    
    // MARK: - ProgressArrowImageView setup
    private lazy var progressArrowImageView: UIImageView = {
        let myImageView = UIImageView(frame: CGRect(x: Int(progressLabel.frame.maxX + 8), y: Int(progressLabel.frame.minY), width: 8, height: 14))
        return myImageView
    }()
    
}

extension ProgressInfoView {
    var circlePoint: CGPoint {
        if startPoint.y < middlePoint.y {
            return CGPoint(x: startPoint.x - circleSize + 2, y: startPoint.y - circleSize / 2)
        }
        else if startPoint.y == middlePoint.y {
            return CGPoint(x: startPoint.x - circleSize + 2, y: startPoint.y - circleSize / 2)
        }
        else {
            return CGPoint(x: startPoint.x - circleSize + 2, y: startPoint.y - circleSize / 2)
        }
    }
}
