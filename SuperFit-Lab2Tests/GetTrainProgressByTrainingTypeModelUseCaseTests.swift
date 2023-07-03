//
//  GetTrainProgressByTrainingTypeModelUseCaseTests.swift
//  SuperFit-Lab2Tests
//
//  Created by Nikita Usov on 30.06.2023.
//

import XCTest
@testable import SuperFit_Lab2

final class GetTrainProgressByTrainingTypeModelUseCaseTests: XCTestCase {

    private var sut: GetTrainProgressByTrainingTypeModelUseCase!

    override func setUpWithError() throws {
        sut = GetTrainProgressByTrainingTypeModelUseCase()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCalculateTrainingProgress_WithNoTrainingList_ReturnsNil() {
        // Given
        let trainingType = TrainingTypeModel.crunch
        let trainingList: [TrainingModel] = []

        // When
        let result = sut.calculateTrainingProgress(trainingType: trainingType, trainingList: trainingList)

        // Then
        XCTAssertNil(result)
    }

    func testCalculateTrainingProgress_WithSingleTraining_ReturnsEmptyProgressClassField() {
        // Given
        let trainingType = TrainingTypeModel.crunch
        let trainingList: [TrainingModel] = [
            TrainingModel(date: "2023-06-01", exercise: .crunch, repeatCount: 10)
        ]

        // When
        let result = sut.calculateTrainingProgress(trainingType: trainingType, trainingList: trainingList)

        // Then
        XCTAssertEqual(result?.progress, "")
    }

    func testCalculateTrainingProgress_WithMultipleMatchingTrainings_ReturnsValidTrainingProgressModel() {
        // Given
        let trainingType = TrainingTypeModel.crunch
        let trainingList: [TrainingModel] = [
            TrainingModel(date: "2023-06-01", exercise: .crunch, repeatCount: 10),
            TrainingModel(date: "2023-06-02", exercise: .crunch, repeatCount: 12),
            TrainingModel(date: "2023-06-03", exercise: .crunch, repeatCount: 8),
            TrainingModel(date: "2023-06-04", exercise: .crunch, repeatCount: 16)
        ]

        // When
        let result = sut.calculateTrainingProgress(trainingType: trainingType, trainingList: trainingList)

        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.lastTrain, "16 times")
        XCTAssertEqual(result?.progress, "100%")
    }

    // swiftlint:disable:next line_length
    func testCalculateTrainingProgress_WithTwoMatchingTrainingsWithEqualDate_ReturnsEmptyProgressClassFieldAndMaxRepeatCount() {
        // Given
        let trainingType = TrainingTypeModel.crunch
        let trainingList: [TrainingModel] = [
            TrainingModel(date: "2023-06-01", exercise: .crunch, repeatCount: 17),
            TrainingModel(date: "2023-06-01", exercise: .crunch, repeatCount: 14)
        ]

        // When
        let result = sut.calculateTrainingProgress(trainingType: trainingType, trainingList: trainingList)

        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.lastTrain, "17 times")
        XCTAssertEqual(result?.progress, "")
    }

}
