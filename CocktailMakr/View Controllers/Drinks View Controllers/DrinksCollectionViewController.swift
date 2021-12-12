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

    // MARK: - Properties
    
    fileprivate let client = APIClient()
    fileprivate var drinkPreviews =  [DrinkPreview]()
    
    var headerTitle: String? = nil
    var drinksObservable: Observable<[DrinkPreview]?>? {
        didSet {
            initDrinkPreviews()
        }
    }
    
    // MARK: - Data Init
    
    fileprivate func initDrinkPreviews() {
        guard let drinksObservable = drinksObservable else { return }

        drinksObservable.subscribe(
            onNext: { drinkPreviews in
                guard let drinkPreviews = drinkPreviews else { return }
                self.drinkPreviews = drinkPreviews
                DispatchQueue.main.async { [weak self] in self?.collectionView.reloadData() }
            },
            onError: { error in
                print("An error occurred while getting the drinks:\n\(error)")
            }
        ).disposed(by: disposeBag)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController()
        
        sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        collectionView.register(UINib(nibName: "DrinkPreviewCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: DrinkPreviewCollectionViewCell.identifier)
    }
}

// MARK: - Navigation

extension DrinksCollectionViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDrinkSegue" {
            let drinkVC = segue.destination as! DrinkViewController
            let indexPath = sender as! IndexPath
            drinkVC.drinkObservable = client.getDrink(with: drinkPreviews[indexPath.row].id)
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension DrinksCollectionViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
}

// MARK: - UICollectionViewDelegate

extension DrinksCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDrinkSegue", sender: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension DrinksCollectionViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: Double = ((view.frame.width - sectionInsets.left * 3) / 2)
        let itemHeight: Double = itemWidth * (20 / 14)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
