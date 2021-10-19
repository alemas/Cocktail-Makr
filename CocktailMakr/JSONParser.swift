//
//  JSONParser.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 18/10/21.
//

import Foundation

class JSONParser {
    
    static func decode(jsonData: Data) throws -> [Drink] {
        
        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
        
        if let jsonDrinks = json["drinks"] as? [Any] {
            let drinksData = try JSONSerialization.data(withJSONObject: jsonDrinks, options: [])
            let decoder = JSONDecoder()
            let drinks = try decoder.decode([Drink].self, from: drinksData)
            return drinks
        }
        return []
    }
    
}
