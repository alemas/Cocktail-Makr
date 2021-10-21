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
    let imageURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case imageURL = "strDrinkThumb"
    }
}

// MARK: Decodable

extension DrinkPreview: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: CodingKeys.id)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        imageURL = URL(string: try values.decode(String.self, forKey: CodingKeys.imageURL)
            .appending("/preview"))
    }
}
