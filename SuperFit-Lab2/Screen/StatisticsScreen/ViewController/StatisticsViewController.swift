//
//  StatisticsViewController.swift
//  SuperFit-Lab2
//
//  Created by Nikita Usov on 26.06.2023.
//

import UIKit
import Charts
import DGCharts

final class StatisticsViewController: UIViewController {

    private let viewModel: StatisticsViewModel
    
    private var tagViews: [TrainingTagView] = []
    
    init(viewModel: StatisticsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.darkGray()
        getLastExercises()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        trainingTagsScrollView.contentOffset = CGPoint(x: trainingTagsScrollView.frame.minX - 20, y: trainingTagsScrollView.contentOffset.y)
    }
    
    // MARK: - BackgroundImage setup
    private lazy var backgroundImage: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = R.image.statisticsBackground()
        myImageView.contentMode = .scaleAspectFill
        return myImageView
    }()
    
    // MARK: - BackArrowButton setup
    private lazy var backArrowButton: UIButton = {
        let myButton = UIButton()
        myButton.setImage(R.image.backwardArrow(), for: .normal)
        myButton.addTarget(self, action: #selector(onBackArrowButtonTapped), for: .touchUpInside)
        myButton.tintColor = R.color.white()
        return myButton
    }()
    @objc private func onBackArrowButtonTapped() {
        viewModel.goBackToMyBodyScreen()
    }
    
    // MARK: - ScrollView setup
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.showsVerticalScrollIndicator = false
        return myScrollView
    }()
    
    // MARK: - ContentView setup
    private lazy var contentView: UIView = {
        let myView = UIView()
        return myView
    }()
    
    // MARK: - WeightLabel setup
    private lazy var weightLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.statisticsScreen.weight()
        myLabel.font = R.font.montserratBold(size: 24)
        myLabel.textColor = R.color.white()
        return myLabel
    }()
    
    // MARK: - LineChart setup
    private lazy var lineChart: LineChartView = {
        let myLineChart = LineChartView()
        myLineChart.drawBordersEnabled = false
        myLineChart.dragEnabled = false
        myLineChart.doubleTapToZoomEnabled = false
        
        myLineChart.borderColor = R.color.white()!
        
        myLineChart.legend.enabled = false
        
        myLineChart.rightAxis.labelTextColor = R.color.clear()!
        myLineChart.rightAxis.spaceBottom = 80
        
        myLineChart.leftAxis.labelTextColor = R.color.white()!
        myLineChart.leftAxis.gridLineWidth = 1.0
        myLineChart.leftAxis.gridColor = R.color.white()!
        myLineChart.leftAxis.labelCount = 2
        myLineChart.leftAxis.labelTextColor = R.color.white()!
        myLineChart.leftAxis.labelFont = R.font.robotoRegular(size: 10)!
        myLineChart.leftAxis.granularity = 5
        myLineChart.leftAxis.spaceBottom = 80
        
        myLineChart.xAxis.gridColor = R.color.white()!
        myLineChart.xAxis.gridLineWidth = 1.0
        myLineChart.xAxis.labelPosition = .bottom
        myLineChart.xAxis.labelTextColor = R.color.white()!
        myLineChart.xAxis.granularity = 1.0
        myLineChart.xAxis.labelFont = R.font.robotoRegular(size: 10)!
        myLineChart.leftAxis.labelXOffset = -10
        
        myLineChart.drawBordersEnabled = true
        myLineChart.borderLineWidth = 1.0
        myLineChart.borderColor = R.color.white()!
        
        myLineChart.isUserInteractionEnabled = false
        return myLineChart
    }()
    
    // MARK: - TrainingLabel
    private lazy var trainingLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = R.string.statisticsScreen.training()
        myLabel.font = R.font.montserratBold(size: 24)
        myLabel.textColor = R.color.white()
        return myLabel
    }()
    
    // MARK: - TrainingTagsScrollView setup
    private lazy var trainingTagsScrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.showsHorizontalScrollIndicator = false
        return myScrollView
    }()
    
    // MARK: - TrainingTagsStackView setup
    private lazy var trainingTagsStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 16
        return myStackView
    }()
    
    // MARK: - BarChart setup
    private lazy var barChart: BarChartView = {
        let myBarChart = BarChartView()
        myBarChart.drawValueAboveBarEnabled = false
        myBarChart.drawBarShadowEnabled = false
        myBarChart.dragEnabled = false
        myBarChart.doubleTapToZoomEnabled = false
        
        myBarChart.borderColor = R.color.white()!
        
        myBarChart.legend.enabled = false
        
        myBarChart.rightAxis.labelTextColor = R.color.clear()!
        myBarChart.rightAxis.enabled = false
        
        myBarChart.leftAxis.labelTextColor = R.color.white()!
        myBarChart.leftAxis.gridLineWidth = 1.0
        myBarChart.leftAxis.gridColor = R.color.white()!
        myBarChart.leftAxis.labelCount = 5
        myBarChart.leftAxis.spaceTop = 0
        myBarChart.leftAxis.granularity = 5.0
        myBarChart.leftAxis.labelTextColor = R.color.white()!
        myBarChart.leftAxis.labelFont = R.font.robotoRegular(size: 10)!
        
        myBarChart.xAxis.gridColor = R.color.white()!
        myBarChart.xAxis.gridLineWidth = 1.0
        myBarChart.xAxis.granularity = 1.0
        myBarChart.xAxis.labelPosition = .bottom
        myBarChart.xAxis.labelTextColor = R.color.white()!
        myBarChart.xAxis.labelFont = R.font.robotoRegular(size: 10)!
        
        myBarChart.drawBordersEnabled = true
        myBarChart.borderLineWidth = 1.0
        myBarChart.borderColor = R.color.white()!
        
        myBarChart.isUserInteractionEnabled = false
        return myBarChart
    }()
    
    private func setupTrainingTagViews() {
        trainingTagsStackView.addArrangedSubview(addTagView(trainingName: R.string.statisticsScreen.push_ups(), trainingType: .pushUps, trainingTagState: .selected))
        trainingTagsStackView.addArrangedSubview(addTagView(trainingName: R.string.statisticsScreen.plank(), trainingType: .plank, trainingTagState: .normal))
        trainingTagsStackView.addArrangedSubview(addTagView(trainingName: R.string.statisticsScreen.crunch(), trainingType: .crunch, trainingTagState: .normal))
        trainingTagsStackView.addArrangedSubview(addTagView(trainingName: R.string.statisticsScreen.squats(), trainingType: .squats, trainingTagState: .normal))
        trainingTagsStackView.addArrangedSubview(addTagView(trainingName: R.string.statisticsScreen.running(), trainingType: .running, trainingTagState: .normal))
        
    }
    
    private func addTagView(trainingName: String, trainingType: TrainingTypeModel, trainingTagState: TrainingTagState) -> TrainingTagView {
        let myTrainingTagView = TrainingTagView(trainingName: trainingName, trainingType: trainingType, trainingTagState: trainingTagState)
        
        let tagViewGestureRecognizer = TagViewGestureRecognizer(target: self, action: #selector(onTrainingTagViewTapped(_:)))
        tagViewGestureRecognizer.trainingType = trainingType
        myTrainingTagView.addGestureRecognizer(tagViewGestureRecognizer)
        
        tagViews.append(myTrainingTagView)
        return myTrainingTagView
    }
    @objc private func onTrainingTagViewTapped(_ sender: TagViewGestureRecognizer) {
        for tagView in tagViews {
            if tagView.trainingType == sender.trainingType {
                if tagView.trainingTagState != .selected {
                    tagView.trainingTagState = .selected
                    viewModel.selectedTrainingType = tagView.trainingType
                    setupTrainingBarChart()
                }
            }
            else {
                tagView.trainingTagState = .normal
            }
        }
    }

}

final class CustomXAxisValueFormatter: AxisValueFormatter {
    
    let labels: [String] // Массив с текстом для каждого значения

    init(labels: [String]) {
        self.labels = labels
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        if index == 0 || index == labels.count - 1 {
            return labels[index]
        }
        else {
            return ""
        }
    }
}

final class TagViewGestureRecognizer: UITapGestureRecognizer {
    var trainingType: TrainingTypeModel = .pushUps
}

// MARK: - TrainingChart
private extension StatisticsViewController {
    func setupTrainingBarChart() {
        var entries: [BarChartDataEntry] = []
        for (index, trainingInfo) in viewModel.getTrainingResults().enumerated() {
            entries.append(BarChartDataEntry(x: Double(index), y: Double(trainingInfo)))
        }
        
        let set = BarChartDataSet(entries: entries)
        set.colors = [R.color.purple()!]
        set.drawValuesEnabled = false
        
        barChart.xAxis.valueFormatter = CustomXAxisValueFormatter(labels: viewModel.getSortedTrainingDates() ?? [])
        
        let data = BarChartData(dataSet: set)
        
        barChart.leftAxis.axisMaximum = Double(viewModel.getNearestMultipleOfTen(number: viewModel.getTrainingResults().max() ?? 10, toTop: true))
        barChart.leftAxis.axisMinimum = max(Double((viewModel.getNearestMultipleOfTen(number: viewModel.getTrainingResults().min() ?? 10, toTop: false)) - 10), 0)
        
        barChart.data = data
    }
    func setupWeightLineChart() {
        var entries: [ChartDataEntry] = []
        for (index, weightValue) in viewModel.getWeightChanges().enumerated() {
            entries.append(ChartDataEntry(x: Double(index), y: Double(weightValue)))
        }
        
        let set = LineChartDataSet(entries: entries)
        set.lineWidth = 2
        set.circleColors = [R.color.purple()!]
        set.circleHoleColor = R.color.purple()!
        set.circleRadius = 6
        set.colors = [R.color.purple()!]
        set.drawValuesEnabled = false
        
        lineChart.xAxis.valueFormatter = CustomXAxisValueFormatter(labels: viewModel.getSortedWeightChanges() ?? [])

        let data = LineChartData(dataSet: set)
        
        lineChart.data = data
        
        lineChart.leftAxis.axisMaximum = Double(viewModel.getNearestMultipleOfTen(number: viewModel.getWeightChanges().max() ?? 10, toTop: true))
        lineChart.leftAxis.axisMinimum = max(Double(viewModel.getNearestMultipleOfTen(number: viewModel.getWeightChanges().min() ?? 0, toTop: false)), 0)
    }
    
    func setupSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(scrollView)
        view.addSubview(backArrowButton)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(weightLabel)
        contentView.addSubview(lineChart)
        contentView.addSubview(trainingLabel)
        contentView.addSubview(trainingTagsScrollView)
        
        trainingTagsScrollView.addSubview(trainingTagsStackView)
        setupTrainingTagViews()
        contentView.addSubview(barChart)
        
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        backArrowButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
        }
        scrollView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(backArrowButton.snp.bottom)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        weightLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.equalToSuperview().inset(20)
        }
        lineChart.snp.makeConstraints { make in
            make.top.equalTo(weightLabel.snp.bottom).offset(28)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(143 + 30)
        }
        trainingLabel.snp.makeConstraints { make in
            make.top.equalTo(lineChart.snp.bottom).offset(50)
            make.leading.equalToSuperview().inset(20)
        }
        trainingTagsScrollView.snp.makeConstraints { make in
            make.top.equalTo(trainingLabel.snp.bottom).offset(26)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(32)
            make.bottom.equalTo(barChart.snp.top).offset(-40)
            
        }
        trainingTagsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        barChart.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(188 + 30)
            make.top.equalTo(trainingTagsScrollView.snp.bottom).offset(40)
        }
    }
}

// MARK: - Network requests
private extension StatisticsViewController {
    func getLastExercises() {
        Task {
            if await viewModel.getLastExercises() {
                setupTrainingBarChart()
            }
            if await viewModel.getUserParameters() {
                setupWeightLineChart()
            }
        }
    }
}
