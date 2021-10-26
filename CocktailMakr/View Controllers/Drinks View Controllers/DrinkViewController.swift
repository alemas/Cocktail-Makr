//
//  DrinkViewController.swift
//  CocktailMakr
//
//  Created by Mateus Reckziegel on 21/10/21.
//

import UIKit
import RxSwift

class DrinkViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var lblDrinkName: UILabel!
    @IBOutlet var lblIngredientsTitle: UILabel!
    @IBOutlet var lblInstructionsTitle: UILabel!
    @IBOutlet var lblInstructions: UILabel!
    @IBOutlet var stvIngredients: UIStackView!

    // MARK: - Properties
    
    fileprivate var drink: Drink?
    fileprivate var disposeBag = DisposeBag()
    
    var drinkObservable: Observable<[Drink]?>? {
        didSet {
            initDrink()
        }
    }
    
    // MARK: - Data Init
    
    fileprivate func initDrink() {
        guard let drinkObservable = drinkObservable else { return }
        
        drinkObservable.subscribe(
            onNext: { drinks in
                guard let drinks = drinks else { return }
                let drink = drinks[0]
                self.drink = drink
                DispatchQueue.main.async { [weak self] in
                    
                    self?.activityIndicator.stopAnimating()
                    
                    self?.imageView.sd_setImage(with: drink.imageURL, completed: nil)
                    self?.lblDrinkName.text = drink.name
                    self?.lblInstructions.text = drink.instructions
                    for ingredient in drink.ingredients {
                        let lbl = UILabel()
                        lbl.text = ingredient.name
                        self?.stvIngredients.addArrangedSubview(lbl)
                    }
                    
                    self?.lblDrinkName.isHidden = false
                    self?.lblIngredientsTitle.isHidden = false
                    self?.stvIngredients.isHidden = false
                    self?.lblInstructionsTitle.isHidden = drink.instructions == nil
                    self?.lblInstructions.superview?.isHidden = drink.instructions == nil
                }
            },
            onError: { error in
                print("An error occurred while getting the drink:\n\(error)")
            }
        ).disposed(by: disposeBag)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stvIngredients.layer.cornerRadius = 15
        lblInstructions.superview?.layer.cornerRadius = 15
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
