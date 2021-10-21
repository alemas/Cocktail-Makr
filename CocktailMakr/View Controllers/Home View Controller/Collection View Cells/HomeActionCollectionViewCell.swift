//
//  HomeActionCollectionViewCell.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 19/10/21.
//

import UIKit

class HomeActionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override class var identifier: String { "HomeActionCollectionViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        super.setCustomLayout()
        lblTitle.adjustsFontSizeToFitWidth = true
    }
    
    func loadImage(name: String) {
        if let image = UIImage(named: name) {
            imageView.image = image
        }
    }

}
