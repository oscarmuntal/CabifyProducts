//
//  CheckoutOpener.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 26/2/23.
//

import UIKit

protocol CheckoutOpener {
    func openCheckout(with products: [ProductViewModel])
}

extension CheckoutOpener where Self: Pushable, Self: CheckoutWireframe {
    func openCheckout(with products: [ProductViewModel]) {
        push(viewController: CheckoutBuilder(wireframe: self, products: products).buildViewController())
    }
}
