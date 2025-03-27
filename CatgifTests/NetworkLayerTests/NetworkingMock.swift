//
//  NetworkingMock.swift
//  CatgifTests
//
//  Created by Jor . on 26/03/2025.
//

import Foundation

@testable import Catgif

class NetworkingMock: Networking {
    static var data: Data?
    
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        guard let data = NetworkingMock.data else {
            throw NetworkError.dataNotFound
        }
        return (data, URLResponse())
    }
}
