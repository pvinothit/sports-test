//
//  DefaultAPIServiceTests.swift
//  LlyodsTests
//
//  Created by Vinoth Palanisamy on 12/10/2024.
//

import XCTest
import PromiseKit
import PMKFoundation

@testable import Llyods

struct SuccessNetworkClientStub: NetworkClient {
    func request(_: PMKNamespacer, with convertible: any URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)> {
        return .value((MockDataProvider.responseData, URLResponse()))
    }
}

struct GenericFailureNetworkClientStub: NetworkClient {
    func request(_: PMKNamespacer, with convertible: any URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)> {
        return .init(error: NetworkError.cancelled)
    }
}

struct UnauthroisedNetworkClientStub: NetworkClient {
    func request(_: PMKNamespacer, with convertible: any URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)> {
        let hTTPURLResponse = HTTPURLResponse(url: URL(string: "https://test.com")!, statusCode: 401, httpVersion: "1.0", headerFields: nil)
        return .value((Data(), hTTPURLResponse!))    }
}

final class DefaultAPIServiceTests: XCTestCase {
    
    func testSuccessCall() {
        let expectation = expectation(description: "testSuccessCall")
        let sut = DefaultAPIService(networkClient: SuccessNetworkClientStub())
        
        sut.request(endpoint: LeagueEndpoints.leagues, responseType: Response<[LeagueDTO]>.self)
            .done { response in
                XCTAssertEqual(response.data, MockDataProvider.leaguesDTO)
                expectation.fulfill()
            }.catch { error in
                XCTFail()
            }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFailureUnAuthorisedCall() {
        let expectation = expectation(description: "testFailureUnAuthorisedCall")
        let sut = DefaultAPIService(networkClient: UnauthroisedNetworkClientStub())
        
        sut.request(endpoint: LeagueEndpoints.leagues, responseType: Response<[LeagueDTO]>.self)
            .done { response in
                XCTFail()
            }.catch { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFailureCall() {
        let expectation = expectation(description: "testFailureUnAuthorisedCall")
        let sut = DefaultAPIService(networkClient: GenericFailureNetworkClientStub())
        
        sut.request(endpoint: LeagueEndpoints.leagues, responseType: Response<[LeagueDTO]>.self)
            .done { response in
                XCTFail()
            }.catch { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 1)
    }
    
    
}
