//
//  LeaguesRepository.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 10/10/2024.
//

import PromiseKit

protocol LeaguesRepository {
    func fetchLeagues() -> Promise<[League]>
}

