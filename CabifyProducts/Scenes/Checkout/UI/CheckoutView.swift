//
//  CheckoutView.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 26/2/23.
//

import UIKit

class CheckoutView: UIViewController, CreatableView, CheckoutViewContract {

    var presenter: CheckoutPresenterContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
        print(presenter?.products)
    }

}
