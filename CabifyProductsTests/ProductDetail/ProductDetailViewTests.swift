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
    
    var view: ProductDetailViewContract? {
        didSet {
            setupView()
        }
    }
    
    func addOne() {
        addOneCalled = true
    }
    
    func substractOne() {
        substractOneCalled = true
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
