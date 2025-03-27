//
//  CatBreedViewModel.swift
//  Catgif
//
//  Created by Jor . on 25/03/2025.
//

import Foundation
@MainActor
class CatBreedViewModel: ObservableObject {
    @Published var customError: NetworkError?
    @Published var catBreeds: [CatBreed] = []
    @Published var catImages: [CatImage] = []
    @Published var selectedBreedDetails: CatBreed?
    @Published var selectedBreed: String = "" {
        didSet {
            if !selectedBreed.isEmpty {
                fetchCatImages(by: selectedBreed)
                selectedBreedDetails = catBreeds.first { $0.id == selectedBreed }
            }
        }
    }
    let repository: CatBreedRepository
    init(repository: CatBreedRepository) {
        self.repository = repository
    }
    
    //function to fetch breed details
    func fetchCatBreeds(urlstrng: String) async{
        guard let url = URL(string: urlstrng) else {
            customError = NetworkError.invalidURL
            return
        }
        
        do{
            let list = try await repository.getBreedData(url: url)
            self.catBreeds = list
            
            // Automatic select first breed if none selected
            if self.selectedBreed.isEmpty == true {
                self.selectedBreed = list.first?.id ?? ""
                self.selectedBreedDetails = list.first
            }
        }  catch {
            print(error)
        
        }
    }
    
    //function to fetch images
    func fetchCatImages(by breedId: String) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=20&breed_ids=\(breedId)&api_key=live_Ob9WROkU8K0Ktyp3jjn4vYagdRxt3m5sMGmNwh9mqHxLyxvhl0TDdRnr5AY8Tsou") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching images: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }

            do {
                let images = try JSONDecoder().decode([CatImage].self, from: data)
                DispatchQueue.main.async {
                    self?.catImages = images
                }
            } catch {
                print("Error decoding images: \(error.localizedDescription)")
            }
        }.resume()
        
    }
    
}
