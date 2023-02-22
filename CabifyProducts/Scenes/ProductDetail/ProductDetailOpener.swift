//
//  ProductDetailOpener.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit

protocol ProductDetailOpener {
    func openProductDetail(with product: Product, from viewController: UIViewController)
}

extension ProductDetailOpener where Self: Pushable, Self: ProductDetailWireframe  {
    func openProductDetail(with product: Product, from viewController: UIViewController) {
        let productDetailViewController = ProductDetailBuilder(wireframe: self, product: product).buildViewController()
        viewController.present(productDetailViewController, animated: true, completion: nil)
    }
}
