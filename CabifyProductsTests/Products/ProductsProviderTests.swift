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
    
    func testFetchProductsSuccess() {
        // Given
        let expectedResult = Result<Products, CabifyError>.success(defaultProductsResponse)
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
    
    func testFetchProductsFailure() {
        // Given
        let expectedResult = Result<Products, CabifyError>.failure(.other)
        apiRouter.completionResult = expectedResult
        
        // When
        let cancellable = sut.fetchProducts()
            .sink { completion in
                // Then
                switch completion {
                case .finished: XCTFail("fetchProducts succeeded, expected to fail")
                case .failure(let error): XCTAssertEqual(error, CabifyError.other)
                }
            } receiveValue: { response in
                // Then
                XCTFail("fetchCharacters succeeded, expected to fail")
            }

        // Then
        XCTAssertTrue(apiRouter.requestDecodablePublisherCalled)
        cancellable.cancel()
    }
}

class ApiRouterMock: ApiRouting {
    var requestDecodableCalled = false
    var requestDecodablePublisherCalled = false
    var completionResult: Result<Products, CabifyError>?
    
    func requestDecodable<T>(api: ApiCabify, _ completion: @escaping (Result<T, CabifyError>) -> Void) where T : Decodable {
        requestDecodableCalled = true
        if let result = completionResult as? Result<T, CabifyError> {
            completion(result)
        }
    }
    
    func requestDecodablePublisher<T>(api: ApiCabify) -> AnyPublisher<T, CabifyError> where T : Decodable {
        requestDecodablePublisherCalled = true
        return Deferred {
            Future { promise in
                if let result = self.completionResult as? Result<T, CabifyError> {
                    promise(result)
                }
            }
        }.eraseToAnyPublisher()
    }
    
    
}
