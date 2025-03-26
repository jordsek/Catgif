//
//  Model.swift
//  Catgif
//
//  Created by Jor . on 24/03/2025.
//

import Foundation

// Model for Cat Breed
struct CatBreed: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let description: String?
    let lifeSpan: String
    let temperament: String
    let origin: String
    
}


let breedList = CatBreed(id: "abys",
                         name: "Abyssinian",
                         description: "Native to the Greek islands known as the Cyclades in the Aegean Sea, these are natural cats, meaning they developed without humans getting involved in their breeding. As a breed, Aegean Cats are rare, although they are numerous on their home islands. They are generally friendly toward people and can be excellent cats for families with children.",
                         lifeSpan: "9 - 12",
                         temperament: "Active, Energetic, Independent, Intelligent, Gentle",
                         origin: "Egypt"
                         )


// Model for Cat Image
struct CatImage: Identifiable, Codable, Equatable {
    let id: String
    let url: String
}
