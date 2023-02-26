//
//  RootWireframe.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit

class RootWireframe: RootAwareWireframe {
    var rootViewController: UINavigationController?
    static let shared = RootWireframe()
}

extension RootWireframe: Pushable, ProductsWireframe, ProductDetailWireframe, ProductDetailOpener, CheckoutWireframe, CheckoutOpener {}
