//
//  ProductsView.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit

class ProductsView: UIViewController, CreatableView, ViewWithTable, ProductsViewContract {
    @IBOutlet weak var tableView: UITableView!
    @IBAction func checkoutTapped(_ sender: Any) {
        presenter?.checkoutTapped()
    }
    var table: UITableView { tableView }
    var presenter: ProductsPresenterContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
    }
    
}

extension ProductsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numProducts() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard   let presenter = presenter,
                let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductsTableViewCell else { fatalError() }
        cell.configure(with: presenter.cellViewModel(at: indexPath))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath, from: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
}
