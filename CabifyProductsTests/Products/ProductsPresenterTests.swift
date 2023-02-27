//
//  ProductsPresenterTests.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 27/2/23.
//

import XCTest
import Combine
@testable import CabifyProducts

class ProductsPresenterTests: XCTestCase {
    var sut: ProductsPresenter!
    var interactor: ProductsInteractorMock!
    var router: ProductsRouterMock!
    
    override func setUp() {
        super.setUp()
        interactor = ProductsInteractorMock()
        router = ProductsRouterMock()
        sut = ProductsPresenter(interactor: interactor, router: router)
    }
    
    override func tearDown() {
        interactor = nil
        router = nil
        sut = nil
        super.tearDown()
    }
    
    func testNumProducts() {
        // Given
        sut.products = [defaultProductViewModel, tshirtProductViewModel]
        
        // When
        let numProducts = sut.numProducts()
        
        // Then
        XCTAssertEqual(numProducts, 2)
    }
    
    func testCellViewModel() {
        // Given
        sut.products = [defaultProductViewModel, tshirtProductViewModel]
        
        // When
        let indexPath = IndexPath(row: 1, section: 0)
        let cellViewModel = sut.cellViewModel(at: indexPath)
        
        // Then
        XCTAssertEqual(cellViewModel.code, "TSHIRT")
        XCTAssertEqual(cellViewModel.name, "T-shirt")
        XCTAssertEqual(cellViewModel.price, 20.0)
        XCTAssertEqual(cellViewModel.detail, "T-shirt detail")
        XCTAssertEqual(cellViewModel.imageName, "tshirt")
        XCTAssertEqual(cellViewModel.promotion.type, PromotionType.bulk)
        XCTAssertEqual(cellViewModel.promotion.amountToBuy, 3)
        XCTAssertNil(cellViewModel.promotion.amountFree)
        XCTAssertEqual(cellViewModel.promotion.priceWithDiscount, 19.0)
        XCTAssertEqual(cellViewModel.quantity, 0)
    }
    
    func testDidSelectItem() {
        // Given
        sut.products = [defaultProductViewModel, tshirtProductViewModel]
        
        // When
        let indexPath = IndexPath(row: 1, section: 0)
        sut.didSelectItem(at: indexPath, from: UIViewController())
        
        // Then
        XCTAssertTrue(router.openProductDetailCalled)
        XCTAssertEqual(router.productToOpen?.code, "TSHIRT")
        XCTAssertEqual(router.productToOpen?.name, "T-shirt")
        XCTAssertEqual(router.productToOpen?.price, 20.0)
        XCTAssertEqual(router.productToOpen?.detail, "T-shirt detail")
        XCTAssertEqual(router.productToOpen?.imageName, "tshirt")
        XCTAssertEqual(router.productToOpen?.promotion.type, PromotionType.bulk)
        XCTAssertEqual(router.productToOpen?.promotion.amountToBuy, 3)
        XCTAssertNil(router.productToOpen?.promotion.amountFree)
        XCTAssertEqual(router.productToOpen?.promotion.priceWithDiscount, 19.0)
        XCTAssertEqual(router.productToOpen?.quantity, 0)
    }
    
    func testCheckoutTapped() {
        // Given
        sut.products = [tshirtProductViewModel, voucherProductViewModel]
        
        // When
        sut.checkoutTapped()
        
        // Then
        XCTAssertTrue(router.navigateToCheckoutCalled)
        XCTAssertEqual(router.productsToSendToCheckout.count, 2)
        XCTAssertEqual(router.productsToSendToCheckout.first?.code, "TSHIRT")
        XCTAssertEqual(router.productsToSendToCheckout.first?.name, "T-shirt")
        XCTAssertEqual(router.productsToSendToCheckout.first?.price, 20.0)
    }
    
    func testConfigureCheckoutButtonEmptyOfProductsToBuy() {
        // Given
        sut.products = [tshirtProductViewModel]
        let viewMock = ProductsViewMock()
        sut.view = viewMock
        
        // When
        sut.configureCheckoutButton()
        
        // Then
        XCTAssertTrue(viewMock.enableCheckoutButtonCalled)
        XCTAssertFalse(viewMock.buttonEnabled)
    }
    
    func testConfigureCheckoutButtonWithProductsSelectedToBuy() {
        // Given
        sut.products = [tshirtQuantityThreeProductViewModel]
        let viewMock = ProductsViewMock()
        sut.view = viewMock
        
        // When
        sut.configureCheckoutButton()
        
        // Then
        XCTAssertTrue(viewMock.enableCheckoutButtonCalled)
        XCTAssertTrue(viewMock.buttonEnabled)
    }
    
    
    func testLoadProducts() {
        // Given
        let product = Product(code: "MUG", name: "Awesome Mug", price: 7.5)
        let products: Products = Products(products: [product])
        interactor.productsMock = products
        let viewMock = ProductsViewMock()
        
        // When
        sut.view = viewMock
//        sut.loadProducts()
        
        // Then
        XCTAssertEqual(self.sut.products.count, 1)
        XCTAssertEqual(self.sut.products[0].code, "MUG")
        XCTAssertEqual(self.sut.products[0].name, "Awesome Mug")
        XCTAssertEqual(self.sut.products[0].price, 7.5)
        XCTAssertEqual(self.sut.products[0].detail, "Wonderful and excusive mugs, designed by special artists")
        XCTAssertEqual(self.sut.products[0].imageName, "mug")
    }
    
}


///-------------------------------------------------------


class ProductsInteractorMock: ProductsInteractorContract {
    var fetchProductsCalled = false
    var productsMock: Products?
    
    func fetchProducts() -> AnyPublisher<Products, Error> {
        fetchProductsCalled = true
        if let products = productsMock {
            return Just(products).setFailureType(to: Error.self).eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "", code: 0, userInfo: nil)).eraseToAnyPublisher()
        }
    }
}

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
