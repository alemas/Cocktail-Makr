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
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let decoder = JSONDecoder()
    
    // MARK: Parse Methods
    
    // Drinks related API calls always return a JSON object containing a key value pair
    // {"drinks": [Drink]}. This method takes this object (data param) and returns the array (in Data form)
    fileprivate func parseDrinksArray(data: Data) -> Data? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            let drinksData = try JSONSerialization.data(withJSONObject: json["drinks"]!, options: [])
            return drinksData
        } catch let error {
            print("An error occurred whilst parsing drinks\n\(error)")
        }
        return nil
    }
    
}

// MARK: API Call Methods

extension APIClient {
    
    fileprivate func decodeAPIResponse<T: Decodable>(url: URL, decodable: T.Type) -> Observable<T> {
        return APIRequest.get(url: url).map { [unowned self] data in
            let drinksData = parseDrinksArray(data: data)!
            return try decoder.decode(decodable, from: drinksData)
        }
    }
    
    // Raw response for this call is {"drinks": [Drink]}
    func getDrink(with id: String) -> Observable<[Drink]> {
        let url = URL(string: APIEndpoints.getDrinkWithID(id).urlString())!
        return decodeAPIResponse(url: url, decodable: [Drink].self)
    }
    
    // Raw response for this call is {"drinks": [Drink]}
    func getDrinks(for searchTerm: String) -> Observable<[Drink]> {
        let url = URL(string: APIEndpoints.getDrinksForSearchTerm(searchTerm).urlString())!
        return APIRequest.get(url: url).map { [unowned self] data in
            let drinksData = parseDrinksArray(data: data)
            return try decoder.decode([Drink].self, from: drinksData!)
        }
    }
    
    // Raw response for this call is {"drinks": [DrinkPreview]}
    func getDrinkPreviews(ingredient: String) -> Observable<[DrinkPreview]> {
        let url = URL(string: APIEndpoints.getDrinkPreviewsForIngredient(ingredient).urlString())!
        return APIRequest.get(url: url).map { [unowned self] data in
            let drinksData = parseDrinksArray(data: data)
            return try decoder.decode([DrinkPreview].self, from: drinksData!)
        }
    }
    
    // Raw response for this call is {"drinks": [DrinkPreview]}
//    func getDrinkPreviews(category: String) -> Observable<[DrinkPreview]> {
//        let url = URL(string: APIEndpoints.getDrinkPreviewsForIngredient(ingredient).urlString())!
//        return APIRequest.get(url: url).map { [unowned self] data in
//            let drinksData = parseDrinksArray(data: data)
//            return try decoder.decode([DrinkPreview].self, from: drinksData!)
//        }
//    }
//
//    func getIngredients() -> Observable<[String]> {
//
//    }
//
//    func getIngredient(with id: String) -> Observable<Ingredient> {
//
//    }
//
//    func getCategories() -> Observable<[String]> {
//
//    }
    
}
