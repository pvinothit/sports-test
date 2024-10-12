//
//  URLSessionNetworkClientTests.swift
//  LlyodsTests
//
//  Created by Vinoth Palanisamy on 12/10/2024.
//

import XCTest
@testable import Llyods

final class URLSessionNetworkClientTests: XCTestCase {
    
    func testInit() {
        let sut = URLSessionNetworkClient()
        
        let promise = sut.request(.promise, with: try! LeagueEndpoints.leagues.urlRequest(with: ProductionEnvironment()))
        
        XCTAssertNotNil(promise)
        XCTAssertTrue(promise.isPending)
    }
}
