//
//  T20LeaguesViewModelTests.swift
//  LlyodsTests
//
//  Created by Vinoth Palanisamy on 12/10/2024.
//

import XCTest
import PromiseKit
@testable import Llyods

private struct NoLeaguesFoundError: Error {}

struct SuccessLeaguesUseCaseStub: LeaguesUseCase {
    func execute() -> Promise<[League]> {
        .value(MockDataProvider.leagues)
    }
}

struct FailingLeaguesUseCaseStub: LeaguesUseCase {
    func execute() -> Promise<[League]> {
        .init(error: NoLeaguesFoundError())
    }
}

final class T20LeaguesViewModelTests: XCTestCase {
    
    func testLeaguesLoaded() throws {
        let expectation = expectation(description: "testLeaguesLoaded")
        
        let sut = T20LeaguesViewModel(leaguesUseCase: SuccessLeaguesUseCaseStub())
        sut.loadLeagues()
            .done { _ in
                XCTAssertEqual(3, sut.leagues.count)
                XCTAssertEqual("Twenty20 International", sut.leagues.first?.name)
                expectation.fulfill()
            }.catch { error in
                XCTFail()
            }
        
        waitForExpectations(timeout: 1)
    }
    
    func testLeaguesFailedToLoad() {
        let expectation = expectation(description: "testLeaguesFailedToLoad")
        
        let sut = T20LeaguesViewModel(leaguesUseCase: FailingLeaguesUseCaseStub())
        sut.loadLeagues()
            .done { _ in
                XCTFail()
            }.catch { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 1)
    }
    
    func testSearchWith20ReturnsTwoLeagues() {
        let expectation = expectation(description: "testSearchWith20ReturnsTwoLeagues")
        
        let sut = T20LeaguesViewModel(leaguesUseCase: SuccessLeaguesUseCaseStub())
        _ = sut.loadLeagues()
        
        firstly {
            sut.loadLeagues()
        }.then { _ in
            sut.search(query: "20")
        }.done { _ in
            XCTAssertEqual(2, sut.leagues.count)
            expectation.fulfill()
        }.catch { error in
            XCTFail()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testEmptySearchReturnsAllResults() {
        let expectation = expectation(description: "testEmptySearchReturnsAllResults")
        
        let sut = T20LeaguesViewModel(leaguesUseCase: SuccessLeaguesUseCaseStub())
        _ = sut.loadLeagues()
        
        firstly {
            sut.loadLeagues()
        }.then { _ in
            sut.search(query: "")
        }.done { _ in
            XCTAssertEqual(3, sut.leagues.count)
            expectation.fulfill()
        }.catch { error in
            XCTFail()
        }
        
        waitForExpectations(timeout: 1)
    }
}
