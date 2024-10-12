//
//  T20LeaguesRepositoryTests.swift
//  LlyodsTests
//
//  Created by Vinoth Palanisamy on 12/10/2024.
//

import XCTest
import PromiseKit
@testable import Llyods

struct SuccessLeaguesAPIServiceStub: APIService {
    func request<T>(endpoint: any Llyods.Endpoint, responseType: T.Type) -> PromiseKit.Promise<T> where T : Decodable {
        return .value(MockDataProvider.response as! T)
    }
}

struct FailureLeaguesAPIServiceStub: APIService {
    func request<T>(endpoint: any Llyods.Endpoint, responseType: T.Type) -> PromiseKit.Promise<T> where T : Decodable {
        return .init(error: NetworkError.notConnected)
    }
}

final class T20LeaguesRepositoryTests: XCTestCase {
    
    func testSuccessfullRequest() {
        let expectation = expectation(description: "testSuccessfullRequest")
        let sut = T20LeaguesRepository(networkService: SuccessLeaguesAPIServiceStub())
        
        sut.fetchLeagues()
            .done { leagues in
                XCTAssertEqual(leagues.count, 3)
                expectation.fulfill()
            }.catch { error in
                XCTFail("Shouldn't call the error")
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 1)
    }
    
    func testError() {
        let expectation = expectation(description: "testError")
        let sut = T20LeaguesRepository(networkService: FailureLeaguesAPIServiceStub())
        
        sut.fetchLeagues()
            .done { leagues in
                XCTFail("Shouldn't call the success")
                expectation.fulfill()
            }.catch { error in
                XCTAssertTrue(error is NetworkError)
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 1)
    }
}
