//
//  Decoder.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 10/10/2024.
//

import Foundation

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data, ofType: T.Type) throws -> T
}

final class JSONResponseDecoder: ResponseDecoder {
    func decode<T>(_ data: Data, ofType: T.Type) throws -> T where T : Decodable {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(ofType, from: data)
    }
}
