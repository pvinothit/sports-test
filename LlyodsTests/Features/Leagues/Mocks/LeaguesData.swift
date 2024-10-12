//
//  LeaguesData.swift
//  LlyodsTests
//
//  Created by Vinoth Palanisamy on 12/10/2024.
//

import Foundation
@testable import Llyods

struct MockDataProvider {
    
    private static let leaguesJSON =
"""
{
    "data": [
        {
            "resource": "leagues",
            "id": 3,
            "season_id": 1292,
            "country_id": 99474,
            "name": "Twenty20 International",
            "code": "T20I",
            "image_path": "https://cdn.sportmonks.com/images/cricket/leagues/3/3.png",
            "type": "phase",
            "updated_at": "2023-12-30T11:09:21.000000Z"
        },
        {
            "resource": "leagues",
            "id": 5,
            "season_id": 1624,
            "country_id": 98,
            "name": "Big Bash League",
            "code": "BBL",
            "image_path": "https://cdn.sportmonks.com/images/cricket/leagues/5/5.png",
            "type": "league",
            "updated_at": "2024-07-18T20:30:27.000000Z"
        },
        {
            "resource": "leagues",
            "id": 10,
            "season_id": 1636,
            "country_id": 146,
            "name": "CSA T20 Challenge",
            "code": "T20C",
            "image_path": "https://cdn.sportmonks.com/images/cricket/leagues/10/10.png",
            "type": "league",
            "updated_at": "2024-07-30T20:43:43.000000Z"
        }
    ]
}
"""
    
    static var responseData: Data { leaguesJSON.data(using: .utf8)! }
    
    static var response: Response<[LeagueDTO]> {
        try! JSONResponseDecoder().decode(leaguesJSON.data(using: .utf8)!, ofType: Response<[LeagueDTO]>.self)
    }
    
    static var leaguesDTO: [LeagueDTO] {
        try! JSONResponseDecoder().decode(leaguesJSON.data(using: .utf8)!, ofType: Response<[LeagueDTO]>.self).data
    }
    
    static var leagues: [League] { leaguesDTO.map { $0.toDomain() } }
}
