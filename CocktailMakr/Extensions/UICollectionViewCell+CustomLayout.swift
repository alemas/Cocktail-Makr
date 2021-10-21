//
//  UICollectionViewCell+Layout.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 20/10/21.
//

import UIKit

extension UICollectionViewCell {
    
    func setCustomLayout() {
        layer.cornerRadius = 15
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor(named: "Shadow")!.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
    }
    
}
