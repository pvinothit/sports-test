//
//  T20LeaguesUseCaseTests.swift
//  LlyodsTests
//
//  Created by Vinoth Palanisamy on 12/10/2024.
//

import XCTest
import PromiseKit
@testable import Llyods

struct SuccessLeaguesRepositoryStub: LeaguesRepository {
    func fetchLeagues() -> Promise<[League]> {
        return Promise.value(MockDataProvider.leagues)
    }
}

struct FailureLeaguesRepositoryStub: LeaguesRepository {
    func fetchLeagues() -> Promise<[League]> {
        return Promise(error: NetworkError.noData)
    }
}

final class T20LeaguesUseCaseTests: XCTestCase {
    
    func testExecuteSuccess() throws {
        let expectation = expectation(description: "testExecuteSuccess")
        let sut = T20LeaguesUseCase(leaguesRepository: SuccessLeaguesRepositoryStub())
        
        sut.execute()
            .done { leagues in
                XCTAssertEqual(leagues.count, 3)
                expectation.fulfill()
            }.catch { error in
                XCTFail("Shouldn't call error")
            }
        
        waitForExpectations(timeout: 1)
    }
    
    func testExecuteFailure() throws {
        let expectation = expectation(description: "testExecuteFailure")
        let sut = T20LeaguesUseCase(leaguesRepository: FailureLeaguesRepositoryStub())
        
        sut.execute()
            .done { leagues in
                XCTFail("Shouldn't call success")
            }.catch { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 1)
    }
    
}
