//
//  CatBreedRepositoryImplementation.swift
//  Catgif
//
//  Created by Jor . on 25/03/2025.
//

import Foundation

final class CatBreedRepositoryImplementation: CatBreedRepository {
    
    
    let networkmanager: Fetchable
    init(networkmanager: Fetchable) {
        self.networkmanager = networkmanager
    }
    func getBreedData(url: URL) async throws -> [CatBreed] {
        do {
            let data = try await networkmanager.getDataFromAPI(url: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode([CatBreed].self, from: data)
            return result
        } catch {
            throw error
        }
    }
}
