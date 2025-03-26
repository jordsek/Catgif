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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                             //Heading
                                Text("Select a Breed")
                                    .font(.title2.bold())
                                    .transition(.opacity)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                //Breed Picker
                breedSelector
    
              if let breed = viewModel.selectedBreedDetails{
                     CatBreedDetailView(breed: breed)
                       .transition(.opacity.combined(with: .move(edge: .leading)))
                }
                //Cat Images List
                imageList
            }
            .padding()
            
            .task {
                await viewModel.fetchCatBreeds(urlstrng: APIEndPoints.CatBreedAPIEndPoint)
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.selectedBreed)
        }
    }
    
    //Breed picker
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
    private var imageList: some View {
        LazyVGrid(columns: gridColumns, spacing: 16) {
            ForEach(viewModel.catImages) { image in
                AsyncImage(url: URL(string: image.url)) { phase in
                    Group {
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else if phase.error != nil {
                            Color.red
                                .overlay(Text("Failed to load image"))
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(8)
                }
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: viewModel.catImages)
    }
}

#Preview {
    CatBreedView(viewModel: CatBreedViewModel(repository: CatBreedRepositoryImplementation(networkmanager: NetworkManager())))
}
