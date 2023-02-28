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
    var result: Result<Products, CabifyError> = .failure(.other)

    func fetchProducts() -> AnyPublisher<Products, CabifyError> {
        return Result.Publisher(result)
            .delay(for: .milliseconds(100), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
