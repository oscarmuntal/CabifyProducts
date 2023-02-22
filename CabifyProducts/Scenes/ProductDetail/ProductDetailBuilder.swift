//
//  ProductDetailBuider.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit

protocol ProductDetailBuilderContract: Builder {
    var wireframe: ProductDetailWireframe { get }
    var product: Product { get }
    func buildViewController() -> UIViewController
    func buildPresenter() -> ProductDetailPresenterContract
    func buildInteractor() -> ProductDetailInteractorContract
}

extension ProductDetailBuilderContract {
    func buildPresenter() -> ProductDetailPresenterContract {
        ProductDetailPresenter(wireframe: wireframe, interactor: buildInteractor(), product: product)
    }
    
    func buildInteractor() -> ProductDetailInteractorContract {
        ProductDetailInteractor()
    }
}

class ProductDetailBuilder: ProductDetailBuilderContract {
    internal let wireframe: ProductDetailWireframe
    internal let product: Product
    
    init(wireframe: ProductDetailWireframe, product: Product) {
        self.wireframe = wireframe
        self.product = product
    }
    
    func buildViewController() -> UIViewController {
        let vc = ProductDetailView.createFromStoryboard()
        vc.presenter = buildPresenter()
        vc.presenter?.product = self.product
        return vc
    }
}
