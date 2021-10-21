//
//  DrinkPreviewCollectionViewCell.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 20/10/21.
//

import UIKit

class DrinkPreviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override class var identifier: String { "DrinkPreviewCollectionViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        super.setCustomLayout()
        lblTitle.adjustsFontSizeToFitWidth = true
        imageView.layer.cornerRadius = 3
    }

}
