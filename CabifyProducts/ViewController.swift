//
//  ViewController.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 21/2/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiRouter.shared.retrieveProducts(api: .products) { (result: Result<Products, Error>) in
            switch result {
            case .success(let productsModel):
                print(productsModel.products)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

