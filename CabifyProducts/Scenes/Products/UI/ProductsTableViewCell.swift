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
    @IBOutlet weak var promotion: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    func configure(with viewModel: ProductCellViewModel) {
        name.text = viewModel.name
        price.text = "\(viewModel.price)"
        promotion.text = viewModel.promotion
        productImage.image = UIImage(named: viewModel.imageName)
    }

}
