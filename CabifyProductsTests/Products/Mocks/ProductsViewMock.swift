//
//  ProductsViewMock.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 27/2/23.
//

import XCTest
@testable import CabifyProducts

class ProductsViewMock: ProductsViewContract {
    var enableCheckoutButtonCalled = false
    var reloadCalled = false
    var buttonEnabled = false
    
    func enableCheckoutButton(enabled: Bool) {
        enableCheckoutButtonCalled = true
        buttonEnabled = enabled
    }
    
    func reload() {
        reloadCalled = true
    }    
}
