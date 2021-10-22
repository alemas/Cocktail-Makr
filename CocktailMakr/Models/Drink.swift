//
//  Cocktail.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 18/10/21.
//

import Foundation

struct Drink {

    struct RecipeIngredient {
        let name: String
        let measure: String?
    }
    
    // MARK: Properties
    
    let id: String
    let name: String
    let isAlcoholic: Bool
    let instructions: String
    let ingredients: [RecipeIngredient]
    let category: String?
    let glassType: String?
    let imageURL: URL?
    
}

// MARK: Decodable

extension Drink: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: CodingKeys.id)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        isAlcoholic = try values.decode(String.self, forKey: CodingKeys.isAlcoholic) == "Alcoholic"
        instructions = try values.decode(String.self, forKey: CodingKeys.instructions)
        category = try? values.decode(String.self, forKey: CodingKeys.category)
        glassType = try? values.decode(String.self, forKey: CodingKeys.glassType)
        imageURL = try? values.decode(URL.self, forKey: CodingKeys.imageURL)
        
        var tempIngredients = [RecipeIngredient]()
        
        for i in (1...15) {
            let ingredientKey = CodingKeys.init(rawValue: "strIngredient\(i)")!
            guard let ingredientName = try? values.decode(String.self, forKey: ingredientKey) else { break }
            
            let measureKey = CodingKeys.init(rawValue: "strMeasure\(i)")!
            let measure = try? values.decode(String.self, forKey: measureKey)
            
            tempIngredients.append(RecipeIngredient(name: ingredientName, measure: measure))
        }
        
        ingredients = tempIngredients
        
    }
}

