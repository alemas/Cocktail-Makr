//
//  IngredientsCollectionViewController.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 26/10/21.
//

import UIKit
import RxSwift

class IngredientsCollectionViewController: CollectionViewController {

    // MARK: - Properties
    
    fileprivate var ingredientPreviews = [IngredientPreview]()
    fileprivate var client = APIClient()
    
    // MARK: - Data Init
    
    private func initIngredients() {
        client.getIngredientPreviews().subscribe(
            onNext: { ingredientPreviews in
                guard var ingredientPreviews = ingredientPreviews else { return }
                ingredientPreviews.sort { lhs, rhs in
                    return lhs.name < rhs.name
                }
                self.ingredientPreviews = ingredientPreviews
                DispatchQueue.main.async { [weak self] in self?.collectionView.reloadData() }
            },
            onError: { error in
                print("An error occurred while getting the ingredient previews:\n\(error)")
            }
        ).disposed(by: disposeBag)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initIngredients()
        
        collectionView.register(UINib(nibName: "IngredientPreviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: IngredientPreviewCollectionViewCell.identifier)
        
    }
}

// MARK: - Navigation

extension IngredientsCollectionViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDrinksWithIngredientSegue" {
            let drinksVC = segue.destination as! DrinksCollectionViewController
            let indexPath = sender as! IndexPath
            let ingredientName = ingredientPreviews[indexPath.row].name
            drinksVC.drinksObservable = client.getDrinkPreviews(ingredient: ingredientName)
            drinksVC.headerTitle = "Drinks with \(ingredientPreviews[indexPath.row].name)"
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension IngredientsCollectionViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredientPreviews.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientPreviewCollectionViewCell.identifier, for: indexPath) as! IngredientPreviewCollectionViewCell
    
        let ingredientPreview = ingredientPreviews[indexPath.row]
        
        cell.lblTitle.text = ingredientPreview.name
        cell.imageView.sd_setImage(with: ingredientPreview.imageURL, completed: nil)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                  ofKind: kind,
                  withReuseIdentifier: HeaderCollectionReusableView.identifier,
                  for: indexPath) as! HeaderCollectionReusableView
            
            if ingredientPreviews.isEmpty {
                headerView.lblTitle.isHidden = true
                headerView.activityIndicator.startAnimating()
            } else {
                headerView.lblTitle.isHidden = false
                headerView.lblTitle.text = "Ingredients"
                headerView.activityIndicator.stopAnimating()
            }
            return headerView
        }
        fatalError()
    }
}

// MARK: - UICollectionViewDelegate

extension IngredientsCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDrinksWithIngredientSegue", sender: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension IngredientsCollectionViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: Double = ((view.frame.width - sectionInsets.left * 3) / 2)
        let itemHeight: Double = itemWidth * 0.5
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
