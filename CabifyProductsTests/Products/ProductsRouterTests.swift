//
//  ProductsRouterTests.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 28/2/23.
//

import XCTest
import Combine
@testable import CabifyProducts

class ProductsRouterTests: XCTestCase {
    var sut: ProductsRouter!
    var wireframe: ProductsWireframeMock!
    
    override func setUp() {
        super.setUp()
        wireframe = ProductsWireframeMock()
        sut = ProductsRouter(wireframe: wireframe)
    }
    
    override func tearDown() {
        wireframe = nil
        sut = nil
        super.tearDown()
    }
    
    func testDidSelectProduct() {
        // Given
        let product = tshirtProductViewModel
        
        // When
        sut.didSelect(productViewModel: product, from: UIViewController())
        
        // Then
        XCTAssertTrue(wireframe.openProductDetailCalled)
        XCTAssertNotNil(wireframe.product)
        XCTAssertEqual(wireframe.product?.code, "TSHIRT")
        XCTAssertEqual(wireframe.product?.name, "T-shirt")
        XCTAssertEqual(wireframe.product?.price, 20.0)
        XCTAssertEqual(wireframe.product?.detail, "T-shirt detail 1")
        XCTAssertEqual(wireframe.product?.imageName, "tshirt")
        XCTAssertEqual(wireframe.product?.promotion.type, .bulk)
        XCTAssertEqual(wireframe.product?.promotion.amountToBuy, 3)
        XCTAssertEqual(wireframe.product?.promotion.priceWithDiscount, 19.0)
        XCTAssertEqual(wireframe.product?.quantity, 0)
    }
    
    func testNavigateToCheckout() {
        // Given
        let products = [tshirtProductViewModel, tshirtQuantityThreeProductViewModel]
        
        // When
        sut.navigateToCheckout(products: products)
        
        // Then
        XCTAssertTrue(wireframe.openCheckoutCalled)
        XCTAssertEqual(wireframe.products.count, 2)
        XCTAssertEqual(wireframe.products[0].code, "TSHIRT")
        XCTAssertEqual(wireframe.products[1].code, "TSHIRT")
        XCTAssertEqual(wireframe.products[0].name, "T-shirt")
        XCTAssertEqual(wireframe.products[1].name, "T-shirt")
        XCTAssertEqual(wireframe.products[0].price, 20.0)
        XCTAssertEqual(wireframe.products[1].price, 20.0)
        XCTAssertEqual(wireframe.products[0].detail, "T-shirt detail 1")
        XCTAssertEqual(wireframe.products[1].detail, "T-shirt detail 2")
        XCTAssertEqual(wireframe.products[0].quantity, 0)
        XCTAssertEqual(wireframe.products[1].quantity, 3)
    }
}
