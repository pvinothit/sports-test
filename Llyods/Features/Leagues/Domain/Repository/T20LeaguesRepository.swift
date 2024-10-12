//
//  T20LeaguesRepository.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 10/10/2024.
//

import PromiseKit

final class T20LeaguesRepository: LeaguesRepository {
    
    private let networkService: APIService
    
    init(networkService: APIService = DefaultAPIService()) {
        self.networkService = networkService
    }
    
    func fetchLeagues() -> Promise<[League]> {
        return firstly {
            networkService.request(endpoint: LeagueEndpoints.leagues, responseType: Response<[LeagueDTO]>.self)
        }.compactMap { response in
            response.data.compactMap({ $0.toDomain() })
        }
    }
}
