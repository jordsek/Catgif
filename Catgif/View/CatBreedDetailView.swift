//
//  CatBreedDetailView.swift
//  Catgif
//
//  Created by Jor . on 25/03/2025.
//

import SwiftUI

struct CatBreedDetailView: View {
    let breed: CatBreed
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(breed.name)
                .font(.title.bold())
                .transition(.opacity)
            
            InfomationDetails(title: "Origin", value: breed.origin)
            InfomationDetails(title: "Origin", value: breed.lifeSpan)
            InfomationDetails(title: "Origin", value: breed.temperament)
            
            Text(breed.description ?? "")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
        .id(breed.id) // new view creation on breed change
    }
}

#Preview {
    CatBreedDetailView(breed: breedList)
}

struct InfomationDetails: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title + ":")
                .fontWeight(.semibold)
            Text(value)
            Spacer()
        }
        .font(.subheadline)
    }
}
