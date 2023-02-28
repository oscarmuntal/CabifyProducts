//
//  ProductsBuilderTests.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 28/2/23.
//

import XCTest
@testable import CabifyProducts

class ProductsBuilderTests: XCTestCase {
    var sut: ProductsBuilder!
    var wireframe: ProductsWireframeMock!
    
    override func setUp() {
        super.setUp()
        wireframe = ProductsWireframeMock()
        sut = ProductsBuilder(wireframe: wireframe)
    }
    
    override func tearDown() {
        sut = nil
        wireframe = nil
        super.tearDown()
    }
    
    func testBuildViewController() {
        // Given
        let view = sut.buildViewController()
        
        // Then
        XCTAssertNotNil(view, "Expected non-nil ViewController")
        XCTAssertTrue(view is ProductsView, "Expected ViewController to be of type ProductsView")
    }
    
    func testBuildViewController2() {
        // Given
        guard let view = sut.buildViewController() as? ProductsView else { return }

        // When
        let presenter = view.presenter

        // Then
        XCTAssertNotNil(presenter, "Expected non-nil presenter")
        XCTAssertTrue(presenter is ProductsPresenter, "Expected presenter to be of type ProductsPresenter")
    }

    func testBuildViewController3() {
        // Given
        guard   let view = sut.buildViewController() as? ProductsView,
                let presenter = view.presenter as? ProductsPresenter else { return }

        // Then
        XCTAssertTrue(presenter.interactor is ProductsInteractor, "Expected presenter's interactor to be of type ProductsInteractor")
        XCTAssertTrue(presenter.router is ProductsRouter, "Expected presenter's router to be of type ProductsRouter")
    }

    func testBuildPresenter() {
        // Given
        let presenter = sut.buildPresenter()

        // Then
        XCTAssertNotNil(presenter)
        XCTAssertTrue(presenter is ProductsPresenterContract)

    }

    func testBuildPresenter2() {
        // Given
        let presenter = sut.buildPresenter()

        // When
        let productsPresenter = presenter as! ProductsPresenter

        // Then
        XCTAssertNotNil(productsPresenter.interactor)
        XCTAssertNotNil(productsPresenter.router)
    }

    func testBuildInteractor() {
        // Given
        let interactor = sut.buildInteractor()

        // Then
        XCTAssertNotNil(interactor)
        XCTAssertTrue(interactor is ProductsInteractorContract)
    }

    func testBuildRouter() {
        // Given
        let router = sut.buildRouter()

        // Then
        XCTAssertNotNil(router)
        XCTAssertTrue(router is ProductsRouterContract)
    }
}
