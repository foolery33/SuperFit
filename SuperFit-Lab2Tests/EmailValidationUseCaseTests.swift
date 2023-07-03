//
//  EmailValidationTests.swift
//  SuperFit-Lab2Tests
//
//  Created by Nikita Usov on 30.06.2023.
//

import XCTest
@testable import SuperFit_Lab2

final class EmailValidationUseCaseTests: XCTestCase {

    private var sut: EmailValidationUseCase!

    override func setUpWithError() throws {
        sut = EmailValidationUseCase()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testIsValidEmail_WithValidEmail_ShouldReturnTrue() {
        // Given
        let validEmail = "test@example.com"

        // When
        let isValid = sut.isValidEmail(validEmail)

        // Then
        XCTAssertTrue(isValid)
    }

    func testIsValidEmail_WithInvalidEmail_ShouldReturnFalse() {
        // Given
        let invalidEmail = "invalid.email"

        // When
        let isValid = sut.isValidEmail(invalidEmail)

        // Then
        XCTAssertFalse(isValid)
    }

    func testIsValidEmail_WithEmptyEmail_ShouldReturnFalse() {
        // Given
        let emptyEmail = ""

        // When
        let isValid = sut.isValidEmail(emptyEmail)

        // Then
        XCTAssertFalse(isValid)
    }

    func testIsValidEmail_WithWhitespaceEmail_ShouldReturnFalse() {
        // Given
        let whitespaceEmail = "test @example.com"

        // When
        let isValid = sut.isValidEmail(whitespaceEmail)

        // Then
        XCTAssertFalse(isValid)
    }

    func testIsValidEmail_WithMultipleAtSigns_ShouldReturnFalse() {
        // Given
        let multipleAtSignsEmail = "test@example@example.com"

        // When
        let isValid = sut.isValidEmail(multipleAtSignsEmail)

        // Then
        XCTAssertFalse(isValid)
    }

    func testIsValidEmail_WithoutDomain_ShouldReturnFalse() {
        // Given
        let withoutDomainEmail = "test@example"

        // When
        let isValid = sut.isValidEmail(withoutDomainEmail)

        // Then
        XCTAssertFalse(isValid)
    }

}
