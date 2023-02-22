//
//  ProductDetailPresenter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Foundation

class ProductDetailPresenter: ProductDetailPresenterContract {
    private let wireframe: ProductDetailWireframe?
    private let interactor: ProductDetailInteractorContract?
    internal var productViewModel: ProductViewModel
    
    init(wireframe: ProductDetailWireframe, interactor: ProductDetailInteractorContract, productViewModel: ProductViewModel) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.productViewModel = productViewModel
    }
    
    var view: ProductDetailViewContract? {
        didSet {
            setupView()
        }
    }
    
}

private extension ProductDetailPresenter {
    func setupView() {
        view?.configure(with: productViewModel)
    }
}
