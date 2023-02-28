//
//  ProductsInteractorMock.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 27/2/23.
//

import XCTest
import Combine
@testable import CabifyProducts

class ProductsInteractorMock: ProductsInteractorContract {
    var fetchProductsCalled = false
    var productsMock: Products?
    
    func fetchProducts() -> AnyPublisher<Products, CabifyError> {
        fetchProductsCalled = true
        if let products = productsMock {
            return Just(products).setFailureType(to: CabifyError.self).eraseToAnyPublisher()
        } else {
            return Fail(error: .other).eraseToAnyPublisher()
        }
    }
}
