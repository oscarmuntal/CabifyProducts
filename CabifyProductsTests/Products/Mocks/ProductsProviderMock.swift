//
//  ProductsProviderMock.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 28/2/23.
//

import XCTest
import Combine
@testable import CabifyProducts

class ProductsProviderMock: ProductsProviderContract {
    var result: Result<Products, Error> = .failure(NSError(domain: "ProductsProviderMock", code: 0, userInfo: nil))

    func fetchProducts() -> AnyPublisher<Products, Error> {
        return Result.Publisher(result)
            .delay(for: .milliseconds(100), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
