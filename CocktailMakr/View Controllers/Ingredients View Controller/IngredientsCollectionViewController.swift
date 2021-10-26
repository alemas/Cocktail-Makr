//
//  IngredientsCollectionViewController.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 26/10/21.
//

import UIKit
import RxSwift

class IngredientsCollectionViewController: CollectionViewController {

    // MARK: - Properties
    
    fileprivate var ingredients = [IngredientPreview]()
    fileprivate var client = APIClient()
    
    // MARK: - Data Init
    
    private func initIngredients() {
        client.getIngredients().subscribe(
            onNext: { ingredients in
                guard let ingredients = ingredients else { return }
                self?.ingredients = ingredients
            }
        ).disposed(by: disposeBag)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
