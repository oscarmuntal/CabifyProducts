//
//  ProductsPresenterMock.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 27/2/23.
//

import XCTest
@testable import CabifyProducts

class ProductsPresenterMock: ProductsPresenterContract {
    var view: ProductsViewContract?
    var numberOfRowsInSection = 0
    var numProductsCalled = false
    var cellViewModelCalled = false
    var didSelectItemCalled = false
    var checkoutTappedCalled = false
    var productViewModel: ProductViewModel = defaultProductViewModel
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    var didSelectItemViewController: UIViewController = UIViewController()
    
    func numProducts() -> Int {
        numProductsCalled = true
        return numberOfRowsInSection
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ProductViewModel {
        cellViewModelCalled = true
        return productViewModel
    }
    
    func didSelectItem(at indexPath: IndexPath, from viewController: UIViewController) {
        didSelectItemCalled = true
        self.indexPath = indexPath
        self.didSelectItemViewController = viewController
    }
    
    func checkoutTapped() {
        checkoutTappedCalled = true
    }
}
