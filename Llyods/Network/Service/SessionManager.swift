//
//  SessionManager.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 10/10/2024.
//

import Foundation
import PromiseKit
import PMKFoundation

protocol NetworkClient {
    func request(_: PMKNamespacer, with convertible: URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)>
}

final class URLSessionNetworkClient: NetworkClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request(_ nameSpacer: PMKNamespacer, with convertible: URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)> {
        return session.dataTask(nameSpacer, with: convertible)
    }
}
