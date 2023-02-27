//
//  ProductsWireframeMock.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 28/2/23.
//

import XCTest
@testable import CabifyProducts

class ProductsWireframeMock: ProductsWireframe {
    var openProductDetailCalled = false
    var openCheckoutCalled = false
    var product: ProductViewModel? = nil
    var products: [ProductViewModel] = []
    
    func openProductDetail(with productViewModel: ProductViewModel, from viewController: UIViewController) {
        openProductDetailCalled = true
        product = productViewModel
    }
    
    func openCheckout(with products: [ProductViewModel]) {
        openCheckoutCalled = true
        self.products = products
    }
}
