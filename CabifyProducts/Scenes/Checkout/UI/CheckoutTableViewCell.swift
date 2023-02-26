//
//  CheckoutTableViewCell.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 26/2/23.
//

import UIKit

class CheckoutTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!

    func configure(with viewModel: ProductViewModel) {
        productImage.image = UIImage(named: viewModel.imageName)
        nameLabel.text = viewModel.name
        quantityLabel.text = "\(viewModel.quantity) x \(viewModel.code)"
        totalPriceLabel.text = "\(viewModel.finalPrice(quantityToBuy: viewModel.quantity)) €"
    }
}
