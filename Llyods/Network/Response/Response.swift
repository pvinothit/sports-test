//
//  Response.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 11/10/2024.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let data: T
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}
