//
//  ProductDetailPresenter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Foundation

class ProductDetailPresenter {
    private let wireframe: ProductDetailWireframe?
    private let interactor: ProductDetailInteractorContract?
    internal var productViewModel: ProductViewModel
    public var quantity: Int {
        didSet {
            view?.setQuantity(with: quantity)
        }
    }
    
    init(wireframe: ProductDetailWireframe, interactor: ProductDetailInteractorContract, productViewModel: ProductViewModel) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.productViewModel = productViewModel
        self.quantity = 1
    }
    
    var view: ProductDetailViewContract? {
        didSet {
            setupView()
        }
    }
}

extension ProductDetailPresenter: ProductDetailPresenterContract {
    func addOne() {
        if quantity < 100 {
            quantity += 1
        }
    }
    
    func substractOne() {
        if quantity > 1 {
            quantity -= 1
        }
    }
}

private extension ProductDetailPresenter {
    func setupView() {
        view?.setQuantity(with: quantity)
        view?.configure(with: productViewModel)
    }
}
