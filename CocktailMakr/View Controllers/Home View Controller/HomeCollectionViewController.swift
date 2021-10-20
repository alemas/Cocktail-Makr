//
//  HomeCollectionViewController.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 18/10/21.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController {

    fileprivate let sectionInsets = UIEdgeInsets(
      top: 15.0,
      left: 15.0,
      bottom: 40.0,
      right: 15.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(APIEndpoints.getCategories.url())
        print(APIEndpoints.getIngredientByID("112").url())
        
        title = "Home"
        collectionView.register(UINib(nibName: "HomeActionCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: HomeActionCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderCollectionReusableView.identifier)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: UICollectionViewDataSource

extension HomeCollectionViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
        // Search Actions Section
            return 2
            
        } else {
        // Browse Categories Section
            return 3
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeActionCollectionViewCell.identifier, for: indexPath) as! HomeActionCollectionViewCell
            if indexPath.row == 0 {
                cell.lblTitle.text = "Search"
                cell.loadImage(name: "Search")
            } else {
                cell.lblTitle.text = "Search by Ingredient"
                cell.loadImage(name: "Search by Ingredient")
            }
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
//            cell.lblTitle.text = "Fancy Category That Takes More Than 1 Line"
            cell.lblTitle.text = "Fancy Category"
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 1 {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                  ofKind: kind,
                  withReuseIdentifier: HeaderCollectionReusableView.identifier,
                  for: indexPath) as! HeaderCollectionReusableView
            
            headerView.lblTitle.text = "Browse categories ajskdak jshasd aksjdh aks daks d"
            return headerView
        }
        fatalError()
    }
    
}


// MARK: UICollectionViewDelegate

extension HomeCollectionViewController {

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

//MARK: UICollectionViewDelegateFlowLayout

extension HomeCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: Double = ((view.frame.width - sectionInsets.left * 3) / 2)
        let itemHeight: Double = indexPath.section == 0 ? itemWidth : itemWidth * 0.625
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 { return CGSize.zero }
        
        let width: Double = view.frame.width
        let height: Double = 40
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
