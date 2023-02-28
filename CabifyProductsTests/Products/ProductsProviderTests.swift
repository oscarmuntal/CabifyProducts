//
//  ProductsProviderTests.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 28/2/23.
//

import XCTest
import Combine
@testable import CabifyProducts

class ProductsProviderTests: XCTestCase {
    var apiRouter: ApiRouterMock!
    var sut: ProductsProvider!
    
    override func setUp() {
        super.setUp()
        apiRouter = ApiRouterMock()
        sut = ProductsProvider(apiRouter: apiRouter)
    }
    
    override func tearDown() {
        apiRouter = nil
        sut = nil
        super.tearDown()
    }
    
    func testFetchProducts() {
        // Given
        let expectedResult = Result<Products, Error>.success(defaultProductsResponse)
        apiRouter.completionResult = expectedResult
        
        // When
        let cancellable = sut.fetchProducts()
            .sink { completion in
                // Then
                switch completion {
                case .failure(let error):
                    XCTFail("fetchProducts failed with error: \(error)")
                case .finished: break
                }
            } receiveValue: { response in
                // Then
                if case .success(let responseValue) = expectedResult {
                    XCTAssertEqual(response.products.first?.code, responseValue.products.first?.code)
                } else {
                    XCTFail("Expected response result to be success but got failure.")
                }
            }

        // Then
        XCTAssertTrue(apiRouter.requestDecodablePublisherCalled)
        cancellable.cancel()
    }
}

class ApiRouterMock: ApiRouting {
    var requestDecodableCalled = false
    var requestDecodablePublisherCalled = false
    var completionResult: Result<Products, Error>?
    
    func requestDecodable<T>(api: ApiCabify, _ completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        requestDecodableCalled = true
        if let result = completionResult as? Result<T, Error> {
            completion(result)
        }
    }
    
    func requestDecodablePublisher<T>(api: ApiCabify) -> AnyPublisher<T, Error> where T : Decodable {
        requestDecodablePublisherCalled = true
        return Deferred {
            Future { promise in
                if let result = self.completionResult as? Result<T, Error> {
                    promise(result)
                }
            }
        }.eraseToAnyPublisher()
    }
    
    
}
