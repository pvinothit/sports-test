//
//  T20LeaguesUseCase.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 10/10/2024.
//

import Foundation
import PromiseKit

protocol LeaguesUseCase {
    func execute() -> Promise<[League]>
}

final class T20LeaguesUseCase: LeaguesUseCase {
    
    private let leaguesRepository: LeaguesRepository
    
    init(leaguesRepository: LeaguesRepository = T20LeaguesRepository()) {
        self.leaguesRepository = leaguesRepository
    }
    
    func execute() -> Promise<[League]> {
        leaguesRepository.fetchLeagues()
    }
}
