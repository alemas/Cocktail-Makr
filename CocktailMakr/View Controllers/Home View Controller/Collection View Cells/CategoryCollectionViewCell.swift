//
//  CategoryCollectionViewCell.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 19/10/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet var lblTitle: UILabel!
    
    override class var identifier: String { "CategoryCollectionViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        super.setCustomLayout()
        
        lblTitle.adjustsFontSizeToFitWidth = true
        
    }

}
