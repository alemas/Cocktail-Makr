//
//  HomeCollectionViewController.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 18/10/21.
//

import UIKit
import RxSwift

class HomeCollectionViewController: UICollectionViewController {
    
    fileprivate let sectionInsets = UIEdgeInsets(
      top: 15.0,
      left: 15.0,
      bottom: 40.0,
      right: 15.0)
    
    let client = APIClient()
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        APIRequest.get(url: URL(string: APIEndpoints.getDrinksForSearchTerm("Negroni").urlString())!)
//            .subscribe { data in
//                do {
//                    for drink in try JSONParser.decode(jsonData: data) { print(drink.name) }
//                } catch {
//                    print(error)
//                }
//            } onError: { error in
//                print(error)
//            } onCompleted: {
//                print("Completed!")
//            } onDisposed: {
//                print("Disposed!")
//            }
//            .disposed(by: disposeBag)

//        client.getDrink(with: "11007")
//            .subscribe(
//                onNext: { drinks in
//                    print(drinks![0].name)
//                },
//                onError: { error in
//                  print("Error: \(error)")
//                }
//            ).disposed(by: disposeBag)
//        
//        client.getDrinks(for: "Negroni").subscribe(
//            onNext: { drinks in
//                if let drinks = drinks { print(drinks[0]); } }
//        ).disposed(by: disposeBag)

//        client.getDrinkPreviews(category: "Ordinary_Drink").subscribe(
//            onNext: { print($0) },
//            onError: { print("Category Error\($0)") }
//        ).disposed(by: disposeBag)
//
//        client.getDrinkPreviews(ingredient: "Vodksa").subscribe(
//            onNext: { print($0) },
//            onError: { print("Ingredient Error\($0)") }
//        ).disposed(by: disposeBag)

//        client.getIngredient(for: "Vodkas").subscribe(
//            onNext: { print("*ingredient\n\(String(describing: $0))")},
//            onError: { print("IIngredient Error\($0)") }
//        ).disposed(by: disposeBag)
        
        client.getCategories().subscribe(
            onNext: { print($0) }
        ).disposed(by: disposeBag)
//
//        client.getIngredients().subscribe(
//            onNext: { print($0) }
//        ).disposed(by: disposeBag)
        
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
