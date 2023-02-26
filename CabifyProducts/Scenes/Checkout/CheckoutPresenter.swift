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
    var products: [ProductViewModel]
    
    init(wireframe: CheckoutWireframe, interactor: CheckoutInteractorContract, router: CheckoutRouterContract, products: [ProductViewModel]) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.router = router
        self.products = products
    }
}
