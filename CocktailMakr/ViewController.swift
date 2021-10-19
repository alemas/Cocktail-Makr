//
//  ViewController.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 18/10/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=11007"
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=ass"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                
                do {
                    for drink in try (JSONParser.decode(jsonData: data)) {
                        print("\(drink.name)")
                    }
                } catch {
                    print("error")
                }
                
            }
        }
        
    }


}

