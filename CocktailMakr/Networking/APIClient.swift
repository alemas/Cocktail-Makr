//
//  APIClient.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 20/10/21.
//

import Foundation
import RxSwift

class APIClient {
    
    // MARK: Properties
    
    fileprivate let decoder = JSONDecoder()
    
    // MARK: Parse Methods
    
    // For some reason, all API calls return a JSON object whose root is a key value pair
    // {"drinks" | "ingredients": [T]}. This method takes this JSON object (data param) and returns the value array in Data form
    fileprivate func parseRootArray(data: Data) -> Data? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            if !json.isEmpty {
                let rootArrayKeys = ["drinks", "ingredients"]
                
                for key in rootArrayKeys {
                    if let rootArrayJson = json[key] {
                        if rootArrayJson is NSNull {
                            return nil
                        }
                        if let rootData = try? JSONSerialization.data(withJSONObject: rootArrayJson, options: []) {
                            return rootData
                        }
                    }
                }
            }
        } catch let error {
            print("An error occurred whilst parsing the root array:\n\(error)")
        }
        return nil
    }
    
}

// MARK: API Call Methods

extension APIClient {
    
    fileprivate func decodeAPIResponse<T: Decodable>(urlString: String, decodable: T.Type) -> Observable<T?> {
        let url = URL(string: urlString)!
        print(url)
        return APIRequest.get(url: url).map { [self] data in
            guard let data = data else { return nil }
            if let rootData = parseRootArray(data: data) {
                return try decoder.decode(decodable, from: rootData)
            }
            return nil
        }
    }
    
    func getDrink(with id: String) -> Observable<[Drink]?> {
        return decodeAPIResponse(
            urlString: APIEndpoints.getDrinkWithID(id).urlString(),
            decodable: [Drink].self)
    }
    
    func getDrinks(for searchTerm: String) -> Observable<[Drink]?> {
        return decodeAPIResponse(
            urlString: APIEndpoints.getDrinksForSearchTerm(searchTerm).urlString(),
            decodable: [Drink].self)
    }
    
    func getDrinkPreviews(ingredient: String) -> Observable<[DrinkPreview]?> {
        return decodeAPIResponse(
            urlString: APIEndpoints.getDrinkPreviewsForIngredient(ingredient).urlString(),
            decodable: [DrinkPreview].self)
    }
    
    func getDrinkPreviews(category: String) -> Observable<[DrinkPreview]?> {
        return decodeAPIResponse(
            urlString: APIEndpoints.getDrinkPreviewsForCategory(category).urlString(),
            decodable: [DrinkPreview].self)
    }

    func getIngredients() -> Observable<[String]?> {
        return decodeAPIResponse(
            urlString: APIEndpoints.getIngredients.urlString(),
            decodable: [String].self)
    }

    func getIngredient(for searchTerm: String) -> Observable<[Ingredient]?> {
        return decodeAPIResponse(
            urlString: APIEndpoints.getIngredientForSearchTerm(searchTerm).urlString(),
            decodable: [Ingredient].self)
    }

    func getCategories() -> Observable<[Category]?> {
        return decodeAPIResponse(
            urlString: APIEndpoints.getCategories.urlString(),
            decodable: [Category].self)
    }
    
}
