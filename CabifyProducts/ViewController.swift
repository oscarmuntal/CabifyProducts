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
        
        ApiRouter.shared.retrieveProducts(api: .products)
    }
}

