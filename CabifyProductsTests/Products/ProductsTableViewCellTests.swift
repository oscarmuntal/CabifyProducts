//
//  ProductsTableViewCellTests.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 28/2/23.
//

import XCTest
@testable import CabifyProducts

class ProductsTableViewCellTests: XCTestCase {
    let productsViewIdentifier = "ProductsView"
    let cellIdentifier = "productCell"
    var sut: ProductsTableViewCell!
    var viewModel: ProductViewModel!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        let products = [tshirtProductViewModel, tshirtQuantityThreeProductViewModel]
        let dataSource = ProductsDataSource(products: products)
        let storyboard = UIStoryboard(name: productsViewIdentifier, bundle: Bundle(for: ProductsView.self))
        let viewController = storyboard.instantiateViewController(withIdentifier: productsViewIdentifier) as! ProductsView
        _ = viewController.view
        
        tableView = viewController.tableView
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testConfigureWithViewModel() {
        // Given
        sut = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ProductsTableViewCell
        viewModel = tshirtProductViewModel
        
        // When
        sut.configure(with: viewModel)
        sut.layoutIfNeeded()
        
        // Then
        XCTAssertEqual(sut.name?.text, "T-shirt")
        XCTAssertEqual(sut.price?.text, "20.0 €")
        XCTAssertEqual(sut.detail?.text, "T-shirt detail 1")
        XCTAssertEqual(sut.badgeNumber?.text, "")
        XCTAssertEqual(sut.badge?.isHidden, true)
    }
}

class ProductsDataSource: NSObject, UITableViewDataSource {
    private let products: [ProductViewModel]
        
    init(products: [ProductViewModel]) {
        self.products = products
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ProductsTableViewCell()
    }
}
