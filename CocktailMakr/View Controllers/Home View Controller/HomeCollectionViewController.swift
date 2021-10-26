//
//  HomeCollectionViewController.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 18/10/21.
//

import UIKit
import RxSwift

class HomeCollectionViewController: CollectionViewController {
    
    // MARK: Properties
    
    fileprivate let client = APIClient()
    fileprivate var categories = [Category]()
    
    // MARK: Data Init
    
    fileprivate func initCategories() {
        client.getCategories()
            .subscribe(
                onNext: { categories in
                    guard let categories = categories else { return }
                    self.categories = categories
                    DispatchQueue.main.async { self.collectionView.reloadData() }
                },
                onError: { error in
                    print("An error occurred while getting the categories:\n\(error)")
                }
            ).disposed(by: disposeBag)
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCategories()
        
        title = "Home"
        collectionView.register(UINib(nibName: "HomeActionCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: HomeActionCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
}

// MARK: - Navigation

extension HomeCollectionViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = sender as? IndexPath else { return }
        if segue.identifier == "ShowDrinksForCategorySegue" {
            let category = categories[selectedIndexPath.row]
            let drinksCVC = segue.destination as! DrinksCollectionViewController
            drinksCVC.title = category.name
            drinksCVC.headerTitle = category.name
            drinksCVC.drinksObservable = client.getDrinkPreviews(category: category.name)
        }
    }
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
            return categories.count
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
            cell.lblTitle.text = categories[indexPath.row].name
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 1 {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                  ofKind: kind,
                  withReuseIdentifier: HeaderCollectionReusableView.identifier,
                  for: indexPath) as! HeaderCollectionReusableView
            
            if categories.isEmpty {
                headerView.lblTitle.isHidden = true
                headerView.activityIndicator.startAnimating()
            } else {
                headerView.lblTitle.isHidden = false
                headerView.lblTitle.text = "Browse categories"
                headerView.activityIndicator.stopAnimating()
            }
            return headerView
        }
        fatalError()
    }
    
}


// MARK: UICollectionViewDelegate

extension HomeCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        } else {
            performSegue(withIdentifier: "ShowDrinksForCategorySegue", sender: indexPath)
        }
    }

}

//MARK: UICollectionViewDelegateFlowLayout

extension HomeCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 { return CGSize.zero }
        
        let width: Double = view.frame.width
        let height: Double = 40
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: Double = ((view.frame.width - sectionInsets.left * 3) / 2)
        let itemHeight: Double = indexPath.section == 0 ? itemWidth : itemWidth * 0.625
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
