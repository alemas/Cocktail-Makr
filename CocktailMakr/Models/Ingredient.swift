//
//  Ingredient.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 20/10/21.
//

import Foundation

struct Ingredient {
    
    // MARK: Properties
    
    let name: String
    let description: String
    let type: String
    let isAlcoholic: Bool
    let abv: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strIngredient"
        case description = "strDescription"
        case type = "strType"
        case isAlcoholic = "strAlcohol"
        case abv = "strABV"
    }
    
}

// MARK: Decodable

extension Ingredient: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        name = try values.decode(String.self, forKey: CodingKeys.name)
        description = try values.decode(String.self, forKey: CodingKeys.description)
        type = try values.decode(String.self, forKey: CodingKeys.type)
        isAlcoholic = try values.decode(String.self, forKey: CodingKeys.isAlcoholic) == "Alcoholic"
        abv = try values.decode(String.self, forKey: CodingKeys.abv)
        
    }
}

// MARK: Image URL Method

extension Ingredient {
    
    enum ImageSize: String {
        case small = "Small"
        case medium = "Medium"
        case big = ""
    }
    
    func imageURL(size: ImageSize) -> URL? {
        let urlString = API.baseIngredientImageURL.appending("\(size.rawValue)-\(name).png")
        return URL(string: urlString)
    }
    
}
