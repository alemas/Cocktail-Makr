//
//  CollectionViewController.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 20/10/21.
//

import UIKit
import RxSwift

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    let sectionInsets = UIEdgeInsets(
      top: 15.0,
      left: 15.0,
      bottom: 40.0,
      right: 15.0)
    
    let disposeBag = DisposeBag()
    
}
