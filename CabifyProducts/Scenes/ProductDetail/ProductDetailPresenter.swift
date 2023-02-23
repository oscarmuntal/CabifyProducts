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
            DispatchQueue.main.async {
                self.view?.setQuantity(with: self.quantity)
            }
        }
    }
    public var totalPrice: Double {
        Double(quantity) * productViewModel.price
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
        DispatchQueue.main.async {
            self.view?.setQuantity(with: self.quantity)
            self.view?.configure(with: self.productViewModel)
        }
    }
}
