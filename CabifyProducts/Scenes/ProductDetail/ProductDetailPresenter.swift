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
    internal var product: Product
    
    init(wireframe: ProductDetailWireframe, interactor: ProductDetailInteractorContract, product: Product) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.product = product
    }
    
    var view: ProductDetailViewContract? {
        didSet {
            setupView()
        }
    }
    
}

private extension ProductDetailPresenter {
    func setupView() {
        view?.configure(with: product)
    }
}
