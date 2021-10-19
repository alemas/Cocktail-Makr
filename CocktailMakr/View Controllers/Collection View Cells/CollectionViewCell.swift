//
//  CollectionViewCell.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 19/10/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    func setLayout() {
        layer.cornerRadius = 15
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor(named: "Shadow")!.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
    }
    
}
