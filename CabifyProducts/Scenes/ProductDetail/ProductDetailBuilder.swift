//
//  ProductDetailBuider.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit

protocol ProductDetailBuilderContract: Builder {
    var wireframe: ProductDetailWireframe { get }
    var productViewModel: ProductViewModel { get }
    func buildViewController() -> UIViewController
    func buildPresenter() -> ProductDetailPresenterContract
    func buildInteractor() -> ProductDetailInteractorContract
}

extension ProductDetailBuilderContract {
    func buildPresenter() -> ProductDetailPresenterContract {
        ProductDetailPresenter(wireframe: wireframe, interactor: buildInteractor(), productViewModel: productViewModel)
    }
    
    func buildInteractor() -> ProductDetailInteractorContract {
        ProductDetailInteractor()
    }
}

class ProductDetailBuilder: ProductDetailBuilderContract {
    internal let wireframe: ProductDetailWireframe
    internal let productViewModel: ProductViewModel
    
    init(wireframe: ProductDetailWireframe, productViewModel: ProductViewModel) {
        self.wireframe = wireframe
        self.productViewModel = productViewModel
    }
    
    func buildViewController() -> UIViewController {
        let vc = ProductDetailView.createFromStoryboard()
        vc.presenter = buildPresenter()
        return vc
    }
}
