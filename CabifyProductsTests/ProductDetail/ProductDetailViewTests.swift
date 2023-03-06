//
//  ProductDetailViewTests.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 4/3/23.
//

import XCTest
@testable import CabifyProducts

class ProductDetailViewTests: XCTestCase {
    var sut: ProductDetailView!
    var presenter: ProductDetailPresenterMock!
    
    override func setUp() {
        super.setUp()
        presenter = ProductDetailPresenterMock()
        
        let storyboard = UIStoryboard(name: "ProductDetailView", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ProductDetailView") as? ProductDetailView else {
            XCTFail("Couldn't instantiate ProductDetailView from the storyboard")
            return
        }
        _ = viewController.view
        sut = viewController
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        super.tearDown()
    }
    
    func testConfigureWithProductViewModel() {
        // Given
        sut.presenter = presenter
        
        // When
        sut.configure(with: presenter.productViewModel)
        
        // Then
        XCTAssertEqual(sut.productImageView.image, UIImage(named: "tshirt"))
        XCTAssertEqual(sut.name.text, "T-shirt")
        XCTAssertEqual(sut.price.text, "20.0 €")
        XCTAssertEqual(sut.productDescription.text, "T-shirt detail 1")
        XCTAssertEqual(sut.numberOfItems.text, "0")
    }
    
    func testSubstract() {
        // Given
        let expectedQuantity = 3
        presenter.quantity = expectedQuantity
        sut.presenter = presenter
        
        // When
        sut.substract(UIButton())
        
        // Then
        XCTAssertTrue(presenter.substractOneCalled)
        XCTAssertEqual(presenter.substractOneCallCount, expectedQuantity - 1)
    }
    
    func testAdd() {
        // Given
        let expectedQuantity = 8
        presenter.quantity = expectedQuantity
        sut.presenter = presenter
        
        // When
        sut.add(UIButton())
        
        // Then
        XCTAssertTrue(presenter.addOneCalled)
        XCTAssertEqual(presenter.addOneCallCount, expectedQuantity + 1)
    }
}

class ProductDetailPresenterMock: ProductDetailPresenterContract {
    var productViewModel: ProductViewModel = tshirtProductViewModel
    var quantity: Int = 0
    var totalPrice: Double {
        productViewModel.finalPrice
    }
    
    var addOneCalled = false
    var substractOneCalled = false
    var closeModalScreenCalled = false
    var postSelectedItemsCalled = false
    var setupViewCalled = false
    var substractOneCallCount = 0
    var addOneCallCount = 0
    
    var view: ProductDetailViewContract? {
        didSet {
            setupView()
        }
    }
    
    func addOne() {
        addOneCalled = true
        addOneCallCount = quantity + 1
    }
    
    func substractOne() {
        substractOneCalled = true
        substractOneCallCount = quantity - 1
    }
    
    func closeModalScreen(_ viewController: UIViewController) {
        closeModalScreenCalled = true
    }
    
    func postSelectedItems() {
        postSelectedItemsCalled = true
    }
    
    func setupView() {
        setupViewCalled = true
    }
}
