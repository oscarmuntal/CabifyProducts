//
//  CheckoutView.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 26/2/23.
//

import UIKit

class CheckoutView: UIViewController, CreatableView, CheckoutViewContract {

    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var shipping: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBAction func payButtonTapped(_ sender: Any) {
        print("tá tó pagao!")
    }
    var presenter: CheckoutPresenterContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
        title = "Checkout"
        let totalPrice: Double = presenter?.totalPrice ?? 0.0
        subtotal.text = "\(totalPrice) €"
        shipping.text = "Free"
        total.text = "\(totalPrice) €"
        payButton.setTitle("Pay \(totalPrice) €", for: .normal)
    }

}
