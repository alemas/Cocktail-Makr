//
//  DrinksCollectionViewController.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 20/10/21.
//

import UIKit
import RxSwift
import SDWebImage

class DrinksCollectionViewController: CollectionViewController {

    // MARK: Properties
    
    fileprivate let client = APIClient()
    fileprivate var drinkPreviews =  [DrinkPreview]()
    
    var headerTitle: String? = nil
    var drinksObservable: Observable<[DrinkPreview]?>? {
        didSet {
            initDrinkPreviews()
        }
    }
    
    // MARK: Data Init
    
    fileprivate func initDrinkPreviews() {
        guard let drinksObservable = drinksObservable else { return }

        drinksObservable.subscribe(
            onNext: { drinkPreviews in
                guard let drinkPreviews = drinkPreviews else { return }
                self.drinkPreviews = drinkPreviews
                DispatchQueue.main.async { self.collectionView.reloadData() }
            },
            onError: { error in
                print("An error occurred while getting the drinks:\n\(error)")
            }
        ).disposed(by: disposeBag)
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionInsets = UIEdgeInsets(top: 15, left: 15, bottom: 40, right: 15)
        
        collectionView.register(UINib(nibName: "DrinkPreviewCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: DrinkPreviewCollectionViewCell.identifier)
    }
}

// MARK: UICollectionViewDataSource

extension DrinksCollectionViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return drinkPreviews.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkPreviewCollectionViewCell.identifier, for: indexPath) as! DrinkPreviewCollectionViewCell
    
        let drinkPreview = drinkPreviews[indexPath.row]
        
        cell.lblTitle.text = drinkPreview.name
        cell.imageView.sd_setImage(with: drinkPreview.imageURL, completed: nil)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                  ofKind: kind,
                  withReuseIdentifier: HeaderCollectionReusableView.identifier,
                  for: indexPath) as! HeaderCollectionReusableView
            
            if drinkPreviews.isEmpty {
                headerView.lblTitle.isHidden = true
                headerView.activityIndicator.startAnimating()
            } else {
                headerView.lblTitle.isHidden = false
                headerView.lblTitle.text = headerTitle ?? ""
                headerView.activityIndicator.stopAnimating()
            }
            return headerView
        }
        fatalError()
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

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

extension DrinksCollectionViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: Double = ((view.frame.width - sectionInsets.left * 3) / 2)
        let itemHeight: Double = itemWidth * (20 / 14)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
