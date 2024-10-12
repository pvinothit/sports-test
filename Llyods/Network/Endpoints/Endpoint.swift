//
//  Endpoint.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 10/10/2024.
//

import Foundation

enum HTTPMethod: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

enum RequestGenerationError: Error {
    case components
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headerParameters: [String: String] { get }
    var queryParameters: [String: Any] { get }
    var decoder: ResponseDecoder { get }
    
    func urlRequest(with networkConfig: Environment) throws -> URLRequest
}

extension Endpoint {
    
    var decoder: ResponseDecoder { JSONResponseDecoder() }
    
    func urlRequest(with environment: Environment) throws -> URLRequest {
        let url = try url(with: environment)
        var urlRequest = URLRequest(url: url)
        var allHeaders: [String: String] = environment.headers
        headerParameters.forEach { allHeaders.updateValue($1, forKey: $0) }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
    
    private func url(with environment: Environment) throws -> URL {
        let baseURL = environment.baseUrl.absoluteString.last != "/"
        ? environment.baseUrl.absoluteString + "/"
        : environment.baseUrl.absoluteString
        let endpoint = baseURL.appending(path)
        
        guard var urlComponents = URLComponents(
            string: endpoint
        ) else { throw RequestGenerationError.components }
        var urlQueryItems = [URLQueryItem]()
        environment.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }
    
}
