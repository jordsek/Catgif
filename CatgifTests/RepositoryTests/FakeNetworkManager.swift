//
//  FakeNetworkManager.swift
//  CatgifTests
//
//  Created by Jor . on 26/03/2025.
//

import Foundation
@testable import Catgif

class FakeNetworkManager: Fetchable {
    func getDataFromAPI(url: URL) async throws -> Data {
        do{
            let bundle = Bundle(for: FakeNetworkManager.self)
            guard let path = bundle.url(forResource: url.absoluteString, withExtension: "json") else {
                throw NetworkError.invalidURL
            }
            let data = try Data(contentsOf: path)
            return data
        } catch {
            throw NetworkError.dataNotFound
        }
    }
}
