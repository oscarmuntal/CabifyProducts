//
//  ProductsTableViewCellMock.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 27/2/23.
//

import XCTest
@testable import CabifyProducts

class ProductsTableViewCellMock: ProductsTableViewCell {
    var configureCalled = false
    var configureViewModel: ProductViewModel?
    
    override func configure(with viewModel: ProductViewModel) {
        configureCalled = true
        configureViewModel = viewModel
    }
}
