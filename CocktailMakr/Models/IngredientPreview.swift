//
//  IngredientPreview.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 26/10/21.
//

import Foundation

struct IngredientPreview {
    
    // MARK: Properties
    
    let name: String
    let imageURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case name = "strIngredient1"
    }
}

// MARK: Decodable

extension IngredientPreview: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: CodingKeys.name)
        let nameURL = name.replacingOccurrences(of: " ", with: "%20")
        imageURL = URL(string: API.baseIngredientImageURL.appending("\(nameURL)-Small.png"))
    }
}
