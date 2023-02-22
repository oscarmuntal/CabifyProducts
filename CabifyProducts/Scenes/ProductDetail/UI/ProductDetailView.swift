//
//  ProductDetailView.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit

class ProductDetailView: UIViewController, CreatableView {
    public var presenter: ProductDetailPresenterContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
    }
    
}

extension ProductDetailView: ProductDetailViewContract {
    func configure(with product: Product) {
        print("TO DO: Configure Product View")
    }
}
