//
//  ProductsView.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit

class ProductsView: UIViewController, CreatableView, ProductsViewContract {
    @IBOutlet weak var tableView: UITableView!
    var presenter: ProductsPresenterContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
    }
    
}

extension ProductsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductsTableViewCell else { fatalError() }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
}
