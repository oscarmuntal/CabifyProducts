//
//  ProductsInteractorTests.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 27/2/23.
//

import XCTest
import Combine
@testable import CabifyProducts

class ProductsInteractorTests: XCTestCase {
    var sut: ProductsInteractor!
    var provider: ProductsProviderMock!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        provider = ProductsProviderMock()
        sut = ProductsInteractor(productsProvider: provider)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        provider = nil
        sut = nil
        cancellables = nil
    }

    func testFetchProductsSuccess() {
        let expectation = self.expectation(description: "Fetch products should succeed")
        let products = Products(products: [Product(code: "test", name: "Test Product", price: 10.0)])
        provider.result = .success(products)
        var receivedProducts: Products?

        sut.fetchProducts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Expected success, but got failure with error: \(error)")
                case .finished:
                    expectation.fulfill()
                }
            }, receiveValue: { products in
                receivedProducts = products
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(receivedProducts?.products.count, 1)
    }

    func testFetchProductsFailure() {
        let expectation = self.expectation(description: "Fetch products should fail")
        provider.result = .failure(NSError(domain: "TestError", code: 7, userInfo: nil))

        sut.fetchProducts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (TestError error 7.)")
                    expectation.fulfill()
                case .finished:
                    XCTFail("Expected failure, but got success")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
