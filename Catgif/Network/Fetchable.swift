//
//  Fetchable.swift
//  Catgif
//
//  Created by Jor . on 24/03/2025.
//

import Foundation

protocol Fetchable {
    func getDataFromAPI(url: URL) async throws -> Data
}
