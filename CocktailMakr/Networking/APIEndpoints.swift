//
//  APIEndpoints.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 19/10/21.
//

import Foundation

enum APIEndpoints {
    
    case getDrinkByID(String)
    case getDrinksForIngredient(String)
    case getDrinksForSearchTerm(String)
    case getDrinksForCategory(String)
    case getIngredients
    case getIngredientByID(String)
    case getCategories
    
    func url() -> String {
        switch self {
        case .getDrinkByID(let drinkID):
            return composeURL(path: "/lookup.php", params: ["i": drinkID])
        case .getDrinksForIngredient(let ingredient):
            return composeURL(path: "/filter.php", params: ["i": ingredient])
        case .getDrinksForSearchTerm(let searchTerm):
            return composeURL(path: "/search.php", params: ["s": searchTerm])
        case .getDrinksForCategory(let category):
            return composeURL(path: "/category.php", params: ["c": category])
        case .getIngredients:
            return composeURL(path: "/list.php", params: ["i": "list"])
        case .getIngredientByID(let ingredientID):
            return composeURL(path: "/lookup.php", params: ["iid": ingredientID])
        case .getCategories:
            return composeURL(path: "/list.php", params: ["c": "list"])
        }
    }
}

extension APIEndpoints {
    
    fileprivate func composeURL(path: String, params: [String: String]) -> String {
        let url = API.authenticatedBaseURL.appendingPathComponent(path)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        var queryItems = Array(urlComponents.queryItems ?? [])
        
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!.absoluteString
    }
    
}
