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
        presenter?.payButtonTapped()
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
        presenter?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard   let presenter = presenter,
                let cell = tableView.dequeueReusableCell(withIdentifier: "checkoutCell", for: indexPath) as? CheckoutTableViewCell else { fatalError() }
        cell.configure(with: presenter.products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}
