//
//  CatBreedView.swift
//  Catgif
//
//  Created by Jor . on 24/03/2025.
//

import SwiftUI

struct CatBreedView: View {
    @StateObject var viewModel: CatBreedViewModel
    private let gridColumns = [GridItem(.adaptive(minimum: 150))]
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            //Heading
            Text("Select a Breed")
                .font(.title2.bold())
                .transition(.opacity)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            //Breed Picker
            //breedSelector
            
            if let breed = viewModel.selectedBreedDetails{
                   CatBreedDetailView(breed: breed)
                     .transition(.opacity.combined(with: .move(edge: .leading)))
              }
            //Cat Images List
            //imageList
        }
        .padding()
        .task {
            await viewModel.fetchCatBreeds(urlstrng: APIEndPoints.CatBreedAPIEndPoint)
        }
    }
    
    
    //Breed Picker
    private var breedSelector: some View{
        Group {
            Picker("Select a Breed", selection: $viewModel.selectedBreed) {
                Text("Select a breed").tag(nil as String?)
                ForEach(viewModel.catBreeds) { breed in
                    Text(breed.name).tag(breed.id as String?)
                }
            }
            .pickerStyle(.menu)
            .animation(.default, value: viewModel.catBreeds)
            .onChange(of: viewModel.selectedBreed) { newBreed in
                viewModel.fetchCatImages(by: newBreed)
                    
            }
            
        }
    }
    
    //Cat Image List
}

#Preview {
    CatBreedView(viewModel: CatBreedViewModel(repository: CatBreedRepositoryImplementation(networkmanager: NetworkManager())))
}
