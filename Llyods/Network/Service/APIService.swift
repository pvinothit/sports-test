//
//  APIService.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 10/10/2024.
//

import Foundation
import PromiseKit
import PMKFoundation

protocol APIService {
    func request<T>(endpoint: any Endpoint, responseType: T.Type) -> Promise<T> where T : Decodable
}

final class DefaultAPIService: APIService {
    
    private let environment: Environment
    private let networkClient: NetworkClient
    
    init(environment: Environment = ProductionEnvironment(), networkClient: NetworkClient = URLSessionNetworkClient()) {
        self.environment = environment
        self.networkClient = networkClient
    }
    
    func request<T>(endpoint: any Endpoint, responseType: T.Type) -> Promise<T> where T : Decodable {
        return firstly {() -> Promise<URLRequest> in
            return .value(try endpoint.urlRequest(with: environment))
        }.then { [self] request in
            networkClient.request(.promise, with: request)
        }.map { session  in
            // Can handle any errors here added just for demo purpose
            if let statusCode = (session.response as? HTTPURLResponse)?.statusCode, statusCode == 401 {
                throw NetworkError.error(statusCode: statusCode, data: session.data)
            }
            return session.data
        }.compactMap {
            try endpoint.decoder.decode($0, ofType: responseType)
        }
    }
}
