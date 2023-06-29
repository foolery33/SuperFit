//
//  CrunchViewController.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit
import SnapKit
import CoreMotion
import CoreLocation
import AudioToolbox

class ExerciseViewController: UIViewController {
    
    var viewModel: ExerciseViewModel
    
    private let circleScale: CGFloat = UIScreen.main.bounds.width - 2 * 72
    
    private lazy var wentUp = false
    private lazy var wentDown = false
    private lazy var startLocation: CLLocation? = nil
    
    private var initialReps: Int = 100
    
    private var repsCount = 0 {
        willSet {
            if newValue >= initialReps {
                saveTrainingResult(repsCount: initialReps, isCompleted: true)
            }
            else {
                exerciseRepeatLabel.text = "\(initialReps - newValue)"
            }
        }
    }
    
    init(viewModel: ExerciseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.errorHandlingDelegate = self
        initialReps = viewModel.getRepsCount()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.darkGray()
        setupSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        setupCircleLayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        invalidateAllUpdaters()
    }
    
    private func setupSubviews() {
        let trainingType = viewModel.getTrainingType()
        switch trainingType {
        case .pushUps:
            setupPushUps()
            startPushUpsUpdates()
        case .plank:
            setupPlank()
            showPlankAlert()
        case .squats:
            setupSquats()
            startCountingSquats()
        case .crunch:
            setupCrunch()
        case .running:
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            setupRunning()
        }
    }
    
    private func configureExercise(exerciseName: String, repeatLabelText: String, toDoLabelText: String) {
        exerciseLabel.text = exerciseName
        exerciseRepeatLabel.text = repeatLabelText
        exerciseToDoLabel.text = toDoLabelText
    }
    
    // MARK: - BackArrowButton setup
    private lazy var backArrowButton: UIButton = {
        let myButton = UIButton()
        myButton.tintColor = R.color.white()
        myButton.setImage(R.image.backwardArrow(), for: .normal)
        myButton.addTarget(self, action: #selector(goBackToAuthorizationScreen), for: .touchUpInside)
        return myButton
    }()
    @objc private func goBackToAuthorizationScreen() {
        viewModel.goToPreviousScreen()
    }
    private func setupBackArrowButton() {
        view.addSubview(backArrowButton)
        backArrowButton.snp.makeConstraints { make in
            make.centerY.equalTo(exerciseLabel.snp.centerY)
            make.leading.equalToSuperview().inset(25)
        }
    }
    
    // MARK: - ExerciseLabel setup
    private lazy var exerciseLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = R.font.montserratBold(size: 36)
        myLabel.textColor = R.color.white()
        myLabel.numberOfLines = 1
        return myLabel
    }()
    private func setupExerciseLabel() {
        view.addSubview(exerciseLabel)
        exerciseLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: CircleView setup
    private lazy var circleView: UIView = {
        let myView = UIView()
        return myView
    }()
    private func setupCircleView() {
        view.addSubview(circleView)
        setupExerciseRepeatInfoStackView()
        circleView.snp.makeConstraints { make in
            make.top.equalTo(exerciseLabel.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(circleScale)
        }
    }
    
    private lazy var circleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = R.color.purple()?.cgColor
        layer.lineWidth = 4
        return layer
    }()
    
    private func setupCircleLayer() {
        circleView.layer.borderColor = R.color.clear()?.cgColor
        let circleRadius = circleScale / 2
        let circleCenter = circleView.center
        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        
        circleLayer.path = circlePath.cgPath
        view.layer.addSublayer(circleLayer)
        
    }
    
    // MARK: ExerciseRepeatInfoStackView setup
    private lazy var exerciseRepeatInfoStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = 0
        myStackView.alignment = .center
        return myStackView
    }()
    private func setupExerciseRepeatInfoStackView() {
        circleView.addSubview(exerciseRepeatInfoStackView)
        setupExerciseRepeatLabel()
        setupExerciseToDoLabel()
        exerciseRepeatInfoStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - ExerciseRepeatLabel setup
    private lazy var exerciseRepeatLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = R.font.montserratBold(size: 64)
        myLabel.textColor = R.color.white()
        return myLabel
    }()
    private func setupExerciseRepeatLabel() {
        exerciseRepeatInfoStackView.addArrangedSubview(exerciseRepeatLabel)
    }
    
    // MARK: - ExerciseToDoLabel setup
    private lazy var exerciseToDoLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = R.font.montserratBold(size: 16)
        myLabel.textColor = R.color.white()
        myLabel.text = "NEED TO DO"
        return myLabel
    }()
    private func setupExerciseToDoLabel() {
        exerciseRepeatInfoStackView.addArrangedSubview(exerciseToDoLabel)
    }
    
    // MARK: - FinishButton setup
    private lazy var finishButton: FilledButton = {
        let myButton = FilledButton(label: R.string.exerciseScreen.finish(), backColor: R.color.purple()!, textColor: R.color.white()!)
        myButton.addTarget(self, action: #selector(onFinishButtonTapped), for: .touchUpInside)
        return myButton
    }()
    @objc private func onFinishButtonTapped() {
        invalidateAllUpdaters()
        if viewModel.getTrainingType() == .crunch {
            saveTrainingResult(repsCount: initialReps, isCompleted: true)
        }
        else {
            if (viewModel.getTrainingType() == .pushUps || viewModel.getTrainingType() == .running || viewModel.getTrainingType() == .plank) && repsCount != 0 {
                plankTimer.invalidate()
                saveTrainingResult(repsCount: repsCount, isCompleted: false)
            }
            else {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                viewModel.goToExerciseResultScreen(result: .failure, repsLeft: initialReps - repsCount)
            }
        }
    }
    private func setupFinishButton() {
        view.addSubview(finishButton)
        finishButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(25)
        }
    }
    
    private func invalidateAllUpdaters() {
        motionManager.stopAccelerometerUpdates()
        locationManager.stopUpdatingLocation()
        plankTimer.invalidate()
    }
    
    private lazy var motionManager: CMMotionManager = {
        let myMotionManager = CMMotionManager()
        myMotionManager.accelerometerUpdateInterval = 0.1
        return myMotionManager
    }()

    private lazy var locationManager: CLLocationManager = {
        let myLocationManager = CLLocationManager()
        return myLocationManager
    }()
    
    private lazy var plankTimer: Timer = {
        let myTimer = Timer()
        return myTimer
    }()
    
}

private extension ExerciseViewController {
    func setupPushUps() {
        setupExerciseLabel()
        setupCircleView()
        setupFinishButton()
        configureExercise(exerciseName: viewModel.exercise?.name ?? "", repeatLabelText: "\(initialReps)", toDoLabelText: R.string.exerciseScreen.times_left())
    }
    func setupPlank() {
        setupExerciseLabel()
        setupCircleView()
        setupFinishButton()
        configureExercise(exerciseName: viewModel.exercise?.name ?? "", repeatLabelText: "\(initialReps)", toDoLabelText: R.string.exerciseScreen.seconds_left())
    }
    func setupSquats() {
        setupExerciseLabel()
        setupCircleView()
        setupBackArrowButton()
        configureExercise(exerciseName: viewModel.exercise?.name ?? "", repeatLabelText: "\(initialReps)", toDoLabelText: R.string.exerciseScreen.times_left())
    }
    func setupCrunch() {
        setupExerciseLabel()
        setupCircleView()
        setupFinishButton()
        configureExercise(exerciseName: viewModel.exercise?.name ?? "", repeatLabelText: "\(initialReps)", toDoLabelText: R.string.exerciseScreen.need_to_do())
    }
    func setupRunning() {
        setupExerciseLabel()
        setupCircleView()
        setupFinishButton()
        configureExercise(exerciseName: viewModel.exercise?.name ?? "", repeatLabelText: "\(initialReps)", toDoLabelText: R.string.exerciseScreen.meters_passed())
    }
}

// MARK: - Network requests
private extension ExerciseViewController {
    func saveTrainingResult(repsCount: Int, isCompleted: Bool) {
        Task {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            if isCompleted {
                viewModel.goToExerciseResultScreen(result: .success)
            }
            else {
                viewModel.goToExerciseResultScreen(result: .failure, repsLeft: initialReps - repsCount)
            }
            await viewModel.saveTrainingResult(repsCount: repsCount, isCompleted: isCompleted)
        }
    }
}

// MARK: - Push-Ups
private extension ExerciseViewController {
    func startPushUpsUpdates() {
        guard motionManager.isAccelerometerAvailable else {
            print("Accelerometer is not available")
            return
        }
        
        motionManager.accelerometerUpdateInterval = 0.1  // Интервал обновления данных акселерометра (в секундах)
        
        var lastPushUpTimestamp = Date()
        
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
            guard let acceleration = data?.acceleration else { return }
            let threshold = -0.8
            
            if (self?.wentDown ?? false) == false && acceleration.z > threshold + 0.03 {
                self?.wentDown = true
            }
            if (self?.wentDown ?? false) && acceleration.z < threshold - 0.03 {
                self?.wentUp = true
            }
            
            if (self?.wentDown ?? false) && (self?.wentUp ?? false) {
                let currentTimestamp = Date()
                let timeSinceLastPushUp = currentTimestamp.timeIntervalSince(lastPushUpTimestamp)
                
                if timeSinceLastPushUp >= 0.5 {  // Проверяем, прошло ли уже 0.5 секунды с предыдущего отжимания
                    self?.repsCount += 1
                    print("Push-up count increased: \(self?.repsCount ?? 0)")
                    self?.wentUp = false
                    self?.wentDown = false
                    
                    lastPushUpTimestamp = currentTimestamp  // Обновляем время последнего отжимания
                }
            }
        }
    }
}

// MARK: - Squats
private extension ExerciseViewController {
    func startCountingSquats() {
        guard motionManager.isAccelerometerAvailable else {
            print("Accelerometer is not available")
            return
        }
        
        motionManager.accelerometerUpdateInterval = 0.1  // Интервал обновления данных акселерометра (в секундах)
        
        var lastSquatTimestamp = Date()
        
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
            guard let acceleration = data?.acceleration else { return }
            let threshold = 0.0
            
            if (self?.wentDown ?? false) == false && acceleration.y > threshold {
                self?.wentDown = true
            }
            if (self?.wentDown ?? false) && acceleration.y < threshold {
                self?.wentUp = true
            }
            
            if (self?.wentDown ?? false) && (self?.wentUp ?? false) {
                let currentTimestamp = Date()
                let timeSinceLastSquat = currentTimestamp.timeIntervalSince(lastSquatTimestamp)
                
                if timeSinceLastSquat >= 0.5 {  // Проверяем, прошло ли уже 0.5 секунды с предыдущего приседания
                    self?.repsCount += 1
                    print("Squat count increased: \(self?.repsCount ?? 0)")
                    self?.wentUp = false
                    self?.wentDown = false
                    
                    lastSquatTimestamp = currentTimestamp  // Обновляем время последнего приседания
                }
            }
        }
    }
}

// MARK: - Plank
private extension ExerciseViewController {
    func showPlankAlert() {
        showPlankAlert(seconds: initialReps, onLaterButtonTapped: onLaterButtonTapped, onGoButtonTapped: onGoButtonTapped)
    }
    
    var onLaterButtonTapped: (() -> ()) {
        self.viewModel.goToPreviousScreen
    }
    
    var onGoButtonTapped : (() -> ()) {
        startTimer
    }
    
    func startTimer() {
        startFillingCircleAnimation(to: 1, duration: TimeInterval(initialReps))
        plankTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
    }
    
    @objc func timerTick() {
        repsCount += 1 // Уменьшаем количество секунд на 1
        print(repsCount)
        // Проверяем, достигнуто ли значение 0
        if repsCount >= initialReps {
            plankTimer.invalidate() // Останавливаем таймер
        }
    }
    
    private func startFillingCircleAnimation(to endValue: CGFloat, duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = endValue
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        circleLayer.strokeEnd = endValue
        
        circleLayer.add(animation, forKey: "fillingAnimation")
    }
}

// MARK: - CLLocationManagerDelegate (Running)
extension ExerciseViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        if startLocation == nil {
            startLocation = currentLocation
        } else {
            let distance = currentLocation.distance(from: startLocation!)
            updateDistanceTraveled(distance)
        }
    }
    
    private func updateDistanceTraveled(_ distance: CLLocationDistance) {
        // Обновление счетчика пройденного расстояния и выполнение соответствующих действий
        repsCount += Int(distance)
        print("Distance in path: \(repsCount) meters")
        
        // Другие действия, связанные с обновлением интерфейса и т.д.
    }
}

// MARK: - ErrorHandlingDelegate
extension ExerciseViewController: ErrorHandlingDelegate {
    func handleErrorMessage(_ errorMessage: String) {
        DispatchQueue.main.async {
            if errorMessage == R.string.errors.unauthorized() {
                self.showAlert(title: R.string.errors.error(), message: errorMessage) {
                    self.reauthorizeUser()
                }
            }
            else {
                self.showAlert(title: R.string.errors.error(), message: errorMessage)
            }
        }
    }
    
    func reauthorizeUser() {
        viewModel.reauthenticateUser()
    }
}
