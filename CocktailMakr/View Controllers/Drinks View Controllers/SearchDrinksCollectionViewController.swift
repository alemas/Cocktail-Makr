//
//  SearchDrinksCollectionViewController.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 03/11/21.
//

import UIKit

class SearchDrinksCollectionViewController: DrinksCollectionViewController {

    // MARK: - Properties
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchController.searchBar
        
        
    }
}
