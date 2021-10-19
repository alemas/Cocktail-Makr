//
//  CategoryCollectionViewCell.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 19/10/21.
//

import UIKit

class CategoryCollectionViewCell: CollectionViewCell {

    @IBOutlet var lblTitle: UILabel!
    
    override class var identifier: String { "CategoryCollectionViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        super.setLayout()
        
        lblTitle.adjustsFontSizeToFitWidth = true
        
    }

}
