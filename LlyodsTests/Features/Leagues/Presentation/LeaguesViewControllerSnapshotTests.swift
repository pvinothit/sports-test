//
//  LeaguesViewControllerSnapshotTests.swift
//  LlyodsTests
//
//  Created by Vinoth Palanisamy on 12/10/2024.
//

import XCTest
import SnapshotTesting
@testable import Llyods

final class LeaguesViewControllerSnapshotTests: XCTestCase {

    func testLeaguesLoaded() {
        let sut = LeaguesViewController(viewModel: T20LeaguesViewModel(leaguesUseCase: SuccessLeaguesUseCaseStub()))
        sut.viewDidLoad()
        
        assertSnapshot(of: sut, as: .wait(for: 2, on: .image))
    }
}
