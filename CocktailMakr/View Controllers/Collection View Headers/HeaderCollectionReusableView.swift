//
//  HeaderCollectionReusableView.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 19/10/21.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet var lblTitle: UILabel!
    
    override class var identifier: String { "HeaderCollectionReusableView" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
