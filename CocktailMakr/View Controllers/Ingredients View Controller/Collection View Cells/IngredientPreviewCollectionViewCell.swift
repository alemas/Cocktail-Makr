//
//  IngredientPreviewCollectionViewCell.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 26/10/21.
//

import UIKit

class IngredientPreviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override class var identifier: String { "IngredientPreviewCollectionViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCustomLayout()
    }

}
