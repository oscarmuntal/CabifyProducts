//
//  ProductsViewTests.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 27/2/23.
//

import XCTest
@testable import CabifyProducts

class ProductsViewTests: XCTestCase {
    var sut: ProductsView!
    var presenter: ProductsPresenterMock!
    var tableView: UITableViewMock!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "ProductsView", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ProductsView") as? ProductsView else {
            XCTFail("Couldn't instantiate ProductsView from the storyboard")
            return
        }
        _ = viewController.view
        sut = viewController
        presenter = ProductsPresenterMock()
        tableView = UITableViewMock()
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        tableView = nil
        super.tearDown()
    }
    
    func testViewDidLoadShouldSetupPresenter() {
        // Given
        sut.presenter = presenter
        sut.tableView = tableView
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertNotNil(presenter.view)
    }

    func testViewDidLoadShouldSetTitle() {
        // Given
        sut.presenter = presenter
        sut.tableView = tableView
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.title, "Products")
    }
    
    func testViewDidLoadShouldDisableCheckoutButton() {
        // Given
        sut.presenter = presenter
        sut.tableView = tableView
        
        // When
        self.sut.viewDidLoad()
        
        // Then
        XCTAssertFalse(self.sut.checkoutButton.isEnabled)
    }
    
    func testTableViewNumberOfRowsInSectionShouldReturnNumProducts() {
        // Given
        sut.presenter = presenter
        sut.tableView = tableView
        
        // When
        presenter.numberOfRowsInSection = 27
        let numberOfRowsInSection = sut.tableView(tableView, numberOfRowsInSection: 0)

        // Then
        XCTAssertTrue(presenter.numProductsCalled)
        XCTAssertEqual(numberOfRowsInSection, 27)
    }
    
    func testTableViewHeightForRowAtIndexPathShouldReturn150() {
        // Given
        sut.presenter = presenter
        sut.tableView = tableView
        
        // When
        let height = sut.tableView(tableView, heightForRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertEqual(height, 150)
    }
    
    func testTableViewCellForRowAtShouldDequeueCell() {
        // Given
        sut.presenter = presenter
        tableView.register(ProductsTableViewCell.self, forCellReuseIdentifier: "productCell")
        sut.tableView = tableView
        
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(tableView, cellForRowAt: indexPath)
        
        // Then
        XCTAssert(tableView.dequeueReusableCellWithIdentifierCalled)
        XCTAssert(cell is ProductsTableViewCell)
    }
    
    func testTableViewCellForRowAtShouldConfigureCell() {
        // Given
        presenter.productViewModel = tshirtProductViewModel
        sut.presenter = presenter
        tableView.register(ProductsTableViewCellMock.self, forCellReuseIdentifier: "productCell")
        sut.tableView = tableView
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        let cell = sut.tableView(tableView, cellForRowAt: indexPath) as! ProductsTableViewCellMock
        
        // Then
        XCTAssertTrue(cell.configureCalled)
        XCTAssertEqual(cell.configureViewModel?.code, tshirtProductViewModel.code)
        XCTAssertEqual(cell.configureViewModel?.name, tshirtProductViewModel.name)
        XCTAssertEqual(cell.configureViewModel?.detail, tshirtProductViewModel.detail)
        XCTAssertEqual(cell.configureViewModel?.quantity, tshirtProductViewModel.quantity)
        XCTAssertEqual(cell.configureViewModel?.price, tshirtProductViewModel.price)
        XCTAssertEqual(cell.configureViewModel?.finalPrice, tshirtProductViewModel.finalPrice)
    }
    
    func testDidSelectRowAtIndexPathShouldCallPresenter() {
        // Given
        sut.presenter = presenter
        tableView.register(ProductsTableViewCellMock.self, forCellReuseIdentifier: "productCell")
        sut.tableView = tableView
        let indexPath = IndexPath(row: 3, section: 0)
        
        // When
        sut.tableView(tableView, didSelectRowAt: indexPath)
        
        // Then
        XCTAssertTrue(presenter.didSelectItemCalled)
        XCTAssertEqual(presenter.indexPath, indexPath)
        XCTAssertEqual(presenter.didSelectItemViewController, sut)
    }
}
