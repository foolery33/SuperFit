//
//  AuthorizationPinPanelViewModelTests.swift
//  SuperFit-Lab2Tests
//
//  Created by Nikita Usov on 30.06.2023.
//

import XCTest
@testable import SuperFit_Lab2

final class AuthRepositoryTests: XCTestCase {

    private var sut: MockAuthRepository!

    override func setUpWithError() throws {
        sut = MockAuthRepository()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLogin_WhenCredentialsAreCorrect_ShouldReturnToken() {
        let expectation = self.expectation(description: "Login Response Parse Expectation")
        Task {
            do {
                let data = try await sut.login(login: "usov107@gmail.com", password: "1234")
                XCTAssertNotNil(data)
                XCTAssertTrue(sut.loginWasCalled)
                expectation.fulfill()
            } catch let error {
                XCTFail(error.localizedDescription)
            }
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

    func testLogin_WhenCredentialsAreInvalid_ShouldThrowError() {
        let expectation = self.expectation(description: "Login Response Parse Expectation")

        sut.shouldReturnError = true

        Task {
            do {
                let data = try await sut.login(login: "usov107@gmail.com", password: "asdbdsf")
                XCTAssertNil(data)
            } catch let error {
                XCTAssertNotNil(error)
                XCTAssertTrue(sut.loginWasCalled)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

    func testRegister_WhenCredentialsAreCorrect_ShouldReturnToken() {
        let expectation = self.expectation(description: "Register Response Parse Expectation")
        Task {
            do {
                let data = try await sut.register(login: "usov107@gmail.com", password: "1234")
                XCTAssertNotNil(data)
                XCTAssertTrue(sut.registerWasCalled)
                expectation.fulfill()
            } catch let error {
                XCTFail(error.localizedDescription)
            }
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

    func testRegister_WhenCredentialsAreInvalid_ShouldThrowError() {
        let expectation = self.expectation(description: "Register Response Parse Expectation")

        sut.shouldReturnError = true

        Task {
            do {
                let data = try await sut.register(login: "usov107@gmail.com", password: "asdbdsf")
                XCTAssertNil(data)
            } catch let error {
                XCTAssertNotNil(error)
                XCTAssertTrue(sut.registerWasCalled)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

}
