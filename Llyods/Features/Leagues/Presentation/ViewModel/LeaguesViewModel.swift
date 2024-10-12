//
//  T20LeaguesViewModel.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 10/10/2024.
//

import Foundation
import PromiseKit

protocol LeaguesViewModel {
    var leagues: [League] { get }
    
    func loadLeagues() -> Promise<Void>
    func search(query: String) -> Promise<Void>
}

final class T20LeaguesViewModel: LeaguesViewModel {
    
    private let leaguesUseCase: LeaguesUseCase
    
    private(set) var leagues: [League] = []
    
    private var allLeagues: [League] = [] {
        didSet { leagues = allLeagues }
    }
    
    init(leaguesUseCase: LeaguesUseCase = T20LeaguesUseCase()) {
        self.leaguesUseCase = leaguesUseCase
    }
    
    func loadLeagues() -> Promise<Void> {
        Promise { seal in
            firstly {
                leaguesUseCase.execute()
            }.compactMap { [weak self]  leagues in
                self?.allLeagues = leagues
                seal.fulfill(())
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    func search(query: String) -> Promise<Void> {
        Promise { seal in
            if query.isEmpty {
                leagues = allLeagues
                seal.fulfill(())
                return
            }
            leagues = allLeagues.filter { league in
                league.name.lowercased().contains(query.lowercased())
            }
            seal.fulfill(())
        }
    }
}
