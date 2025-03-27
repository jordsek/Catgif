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
    
    func getImageData(breedId: String) async throws -> [CatImage] {
            guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=20&breed_ids=\(breedId)&api_key=live_Ob9WROkU8K0Ktyp3jjn4vYagdRxt3m5sMGmNwh9mqHxLyxvhl0TDdRnr5AY8Tsou") else {
                throw NetworkError.invalidURL
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([CatImage].self, from: data)
        }
}
