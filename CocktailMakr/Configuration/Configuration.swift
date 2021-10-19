//
//  Configuration.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 18/10/21.
//

import Foundation

struct API {
    
    static let APIKey = "1"
    static let baseURL = URL(string: "https://www.thecocktaildb.com/api/json/v1/")!
    
    static var authenticatedBaseURL: URL {
        return baseURL.appendingPathComponent(APIKey)
    }
}
