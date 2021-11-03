//
//  APIEndpoints.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 19/10/21.
//

import Foundation

enum APIEndpoints {
    
    case getDrinkWithID(String)
    case getDrinksForSearchTerm(String)
    case getDrinkPreviewsForIngredient(String)
    case getDrinkPreviewsForCategory(String)
    case getIngredientPreviews
    case getIngredientForSearchTerm(String)
    case getCategories
    
    func urlString() -> String {
        switch self {
        case .getDrinkWithID(let drinkID):
            return composeURL(path: "/lookup.php", params: ["i": drinkID])
        case .getDrinksForSearchTerm(let searchTerm):
            return composeURL(path: "/search.php", params: ["s": searchTerm])
        case .getDrinkPreviewsForIngredient(let ingredient):
            return composeURL(path: "/filter.php", params: ["i": ingredient])
        case .getDrinkPreviewsForCategory(let category):
            return composeURL(path: "/filter.php", params: ["c": category])
        case .getIngredientPreviews:
            return composeURL(path: "/list.php", params: ["i": "list"])
        case .getIngredientForSearchTerm(let searchTerm):
            return composeURL(path: "/search.php", params: ["i": searchTerm])
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
