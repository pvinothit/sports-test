//
//  LeaguesDTO+Mapping.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 10/10/2024.
//

import Foundation 

struct LeagueDTO: Decodable, Equatable {
    let resource: String
    let id, seasonId, countryId: Int
    let name, code: String
    let imagePath: String
    let type, updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case resource, id
        case seasonId = "season_id"
        case countryId = "country_id"
        case name, code
        case imagePath = "image_path"
        case type
        case updatedAt = "updated_at"
    }
}

// MARK: - Mappings to Domain

extension LeagueDTO {
    func toDomain() -> League {
        return .init(id: id, name: name, code: code, type: type)
    }
}
