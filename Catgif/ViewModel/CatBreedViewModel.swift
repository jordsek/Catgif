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
    @MainActor @Published var selectedBreed: String = "" {
        didSet {
            if !selectedBreed.isEmpty {
                //fetchCatImages(by: selectedBreed)
                Task { await fetchCatImages(by: selectedBreed) }
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
    func fetchCatImages(by breedId: String) async {
            do {
                let images = try await repository.getImageData(breedId: breedId)
                await MainActor.run {
                    catImages = images
                }
            } catch {
                await MainActor.run {
                    customError = error as? NetworkError ?? .invalidURL
                }
            }
        }
}
