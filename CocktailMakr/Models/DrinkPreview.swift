//
//  DrinkPreview.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 20/10/21.
//

import Foundation

struct DrinkPreview {
    
    let id: String
    let name: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case imageURL = "strDrinkThumb"
    }
    
}
