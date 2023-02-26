//
//  CheckoutView.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 26/2/23.
//

import UIKit

class CheckoutView: UIViewController, CreatableView, ViewWithTable, CheckoutViewContract {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var shipping: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBAction func payButtonTapped(_ sender: Any) {
        print("tá tó pagao!")
    }
    var presenter: CheckoutPresenterContract?
    var table: UITableView { tableView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
        setup()
    }

}

extension CheckoutView {
    func setup() {
        let totalPrice: Double = presenter?.totalPrice ?? 0.0
        DispatchQueue.main.async {
            self.title = "Checkout"
            self.subtotal.text = "\(totalPrice) €"
            self.shipping.text = "Free"
            self.total.text = "\(totalPrice) €"
            self.payButton.setTitle("Pay \(totalPrice) €", for: .normal)
        }
    }
}

extension CheckoutView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "checkoutCell", for: indexPath) as? CheckoutTableViewCell else { fatalError() }
        return cell
    }
    
    
}
