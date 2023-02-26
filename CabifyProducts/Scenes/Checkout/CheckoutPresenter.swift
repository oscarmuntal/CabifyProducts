//
//  CheckoutPresenter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 26/2/23.
//

import Foundation

class CheckoutPresenter: CheckoutPresenterContract {
    var view: CheckoutViewContract?
    private let wireframe: CheckoutWireframe
    private let interactor: CheckoutInteractorContract
    private let router: CheckoutRouterContract
    public var products: [ProductViewModel]
    public var totalPrice: Double
    
    init(wireframe: CheckoutWireframe, interactor: CheckoutInteractorContract, router: CheckoutRouterContract, products: [ProductViewModel]) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.router = router
        self.products = products.filter { $0.quantity > 0 }
        self.totalPrice = products.reduce(0) { $0 + $1.finalPrice(quantityToBuy: $1.quantity) }
    }
}
