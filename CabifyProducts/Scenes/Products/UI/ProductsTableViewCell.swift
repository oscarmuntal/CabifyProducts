//
//  ProductsTableViewCell.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var badge: UIImageView!
    @IBOutlet weak var badgeNumber: UILabel!
    
    func configure(with viewModel: ProductViewModel) {
        name?.text = viewModel.name
        price?.text = "\(viewModel.price) €"
        detail?.text = viewModel.detail
        productImage?.image = UIImage(named: viewModel.imageName)
        badgeNumber?.text = viewModel.quantity == 0 ? "" : "\(viewModel.quantity)"
        badge?.isHidden = viewModel.quantity == 0 ? true : false
    }
}
