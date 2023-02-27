//
//  ProductsRouterMock.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 27/2/23.
//

import XCTest
@testable import CabifyProducts

class ProductsRouterMock: ProductsRouterContract {
    var openProductDetailCalled = false
    var productToOpen: ProductViewModel? = nil
    var navigateToCheckoutCalled = false
    var productsToSendToCheckout: [ProductViewModel] = []
    
    func didSelect(productViewModel: ProductViewModel, from viewController: UIViewController) {
        openProductDetailCalled = true
        productToOpen = productViewModel
    }
    
    func navigateToCheckout(products: [ProductViewModel]) {
        navigateToCheckoutCalled = true
        productsToSendToCheckout = products
    }
}
