//
//  NetworkConfig.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 10/10/2024.
//

import Foundation

protocol Environment {
    var baseUrl: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

struct ProductionEnvironment: Environment {
    let baseUrl: URL = URL(string: "https://cricket.sportmonks.com/")!
    let headers: [String : String] = [:]
    var queryParameters: [String : String] = ["api_token": "v7dvHtr6wX1pM0dqBFt9OFfFfup36HA62rhxuCesAnEDFEc3hQwxgsLmPxqM"] // Stored here for temporary purpose. This can be moved to Plist and injected runtime.
}
