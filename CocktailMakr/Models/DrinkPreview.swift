//
//  DrinkPreview.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 20/10/21.
//

import Foundation

struct DrinkPreview {
    
    // MARK: Properties
    
    let id: String
    let name: String
    let previewImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case previewImageURL = "strDrinkThumb"
    }
}

// MARK: Decodable

extension DrinkPreview: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: CodingKeys.id)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        previewImageURL = try values.decode(String.self, forKey: CodingKeys.previewImageURL)
            .appending("/preview")
    }
}
