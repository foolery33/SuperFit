//
//  GetNearestMultipleOfTenUseCaseTests.swift
//  SuperFit-Lab2Tests
//
//  Created by Nikita Usov on 30.06.2023.
//

import XCTest
@testable import SuperFit_Lab2

final class GetNearestMultipleOfTenUseCaseTests: XCTestCase {

    private var sut: GetNearestMultipleOfTenUseCase!

    override func setUpWithError() throws {
        sut = GetNearestMultipleOfTenUseCase()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetNearest_WhenToTopIsTrue_ShouldReturnNearestMultipleOfTenToTop() {
        // Given
        let number = 37
        let expectedNearestMultiple = 40

        // When
        let nearestMultiple = sut.getNearest(number: number, toTop: true)

        // Then
        XCTAssertEqual(nearestMultiple, expectedNearestMultiple)
    }

    func testGetNearest_WhenToTopIsFalse_ShouldReturnNearestMultipleOfTenToBottom() {
        // Given
        let number = 37
        let expectedNearestMultiple = 30

        // When
        let nearestMultiple = sut.getNearest(number: number, toTop: false)

        // Then
        XCTAssertEqual(nearestMultiple, expectedNearestMultiple)
    }

    func testGetNearest_WhenNumberIsMultipleOfTen_ShouldReturnSameNumber() {
        // Given
        let number = 50

        // When
        let nearestTopMultiple = sut.getNearest(number: number, toTop: true)
        let nearestBottomMultiple = sut.getNearest(number: number, toTop: false)

        // Then
        XCTAssertEqual(nearestTopMultiple, number)
        XCTAssertEqual(nearestBottomMultiple, number)
    }

}
