//
//  Category.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 20/10/21.
//

import Foundation

struct Category: Decodable {
    
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strCategory"
    }
}
