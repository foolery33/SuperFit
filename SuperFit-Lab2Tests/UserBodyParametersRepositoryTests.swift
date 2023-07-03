//
//  UserBodyParametersRepositoryTests.swift
//  SuperFit-Lab2Tests
//
//  Created by Nikita Usov on 30.06.2023.
//

import XCTest
@testable import SuperFit_Lab2

final class UserBodyParametersRepositoryTests: XCTestCase {

    private var sut: UserBodyParametersRepositoryImplementation!

    override func setUp() {
        sut = UserBodyParametersRepositoryImplementation()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFetchWeight_WhenWeightSaved_ShouldReturnWeight() {
        // Given
        let weight = 70
        sut.saveWeight(weight)

        // When
        let fetchedWeight = sut.fetchWeight()

        // Then
        XCTAssertEqual(fetchedWeight, weight)
    }

    func testFetchWeight_WhenWeightNotSaved_ShouldReturnNil() {
        // When
        let fetchedWeight = sut.fetchWeight()

        // Then
        XCTAssertNil(fetchedWeight)
    }

    func testFetchHeight_WhenHeightSaved_ShouldReturnHeight() {
        // Given
        let height = 170
        sut.saveHeight(height)

        // When
        let fetchedHeight = sut.fetchHeight()

        // Then
        XCTAssertEqual(fetchedHeight, height)
    }

    func testFetchHeight_WhenHeightNotSaved_ShouldReturnNil() {
        // When
        let fetchedHeight = sut.fetchHeight()

        // Then
        XCTAssertNil(fetchedHeight)
    }

    func testSaveWeight_ShouldSaveWeight() {
        // Given
        let weight = 75

        // When
        sut.saveWeight(weight)
        let fetchedWeight = sut.fetchWeight()

        // Then
        XCTAssertEqual(fetchedWeight, weight)
    }

    func testSaveHeight_ShouldSaveHeight() {
        // Given
        let height = 180

        // When
        sut.saveHeight(height)
        let fetchedHeight = sut.fetchHeight()

        // Then
        XCTAssertEqual(fetchedHeight, height)
    }

    func testClearAllData_ShouldClearWeightAndHeight() {
        // Given
        sut.saveWeight(70)
        sut.saveHeight(170)

        // When
        sut.clearAllData()
        let fetchedWeight = sut.fetchWeight()
        let fetchedHeight = sut.fetchHeight()

        // Then
        XCTAssertNil(fetchedWeight)
        XCTAssertNil(fetchedHeight)
    }

}
