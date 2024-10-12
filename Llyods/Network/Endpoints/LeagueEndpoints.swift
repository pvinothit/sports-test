//
//  LeagueEndpoints.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 10/10/2024.
//

enum LeagueEndpoints: Endpoint {
    case leagues

    var path: String {
        switch self {
        case .leagues:
            return "api/v2.0/leagues"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .leagues:
            return .get
        }
    }
    
    var headerParameters: [String : String] { [:] }
    var queryParameters: [String : Any] { [:] }
}
