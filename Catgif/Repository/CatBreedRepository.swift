//
//  CatBreedRepository.swift
//  Catgif
//
//  Created by Jor . on 25/03/2025.
//

import Foundation

protocol CatBreedRepository {
    func getBreedData(url: URL) async throws -> [CatBreed]
}
