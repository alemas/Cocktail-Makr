//
//  Cocktail.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 18/10/21.
//

import Foundation

struct Drink {

    // MARK: Properties
    
    let id: String
    let name: String
    let isAlcoholic: Bool
    let category: String?
    let glassType: String?
//    let thumbnailURL: URL?
    let imageURL: URL?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "idDrink"
        case name = "strDrink"
        case isAlcoholic = "strAlcoholic"
        case category = "strCategory"
        case glassType = "strGlass"
//        case thumbnailURL = "strDrinkThumb"
        case imageURL = "strDrinkThumb"
        
    }
}

// MARK: Decodable

extension Drink: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: CodingKeys.id)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        isAlcoholic = try values.decode(String.self, forKey: CodingKeys.isAlcoholic) == "Alcoholic"
        category = try values.decode(String.self, forKey: CodingKeys.category)
        glassType = try values.decode(String.self, forKey: CodingKeys.glassType)
//        thumbnailURL = try values.decode(String.self, forKey: CodingKeys.thumbnailURL)
        imageURL = try values.decode(URL.self, forKey: CodingKeys.imageURL)
    }
}
