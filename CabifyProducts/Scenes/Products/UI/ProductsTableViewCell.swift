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
        name.text = viewModel.name
        price.text = "\(viewModel.price) €"
        detail.text = viewModel.detail
        productImage.image = UIImage(named: viewModel.imageName)
        badge.isHidden = true
        badgeNumber.text = ""
        let notificationName = Notification.Name("selected items from \(viewModel.name)")
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: notificationName, object: nil)
    }
    
    @objc func handleNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String : Any],
              let quantity = userInfo["quantity"] as? Int else { return }
        badgeNumber.text = quantity == 0 ? "" : "\(quantity)"
        badge.isHidden = quantity == 0 ? true : false
        
    }

}
