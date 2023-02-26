//
//  ProductDetailPresenter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit

class ProductDetailPresenter {
    private let wireframe: ProductDetailWireframe?
    private let interactor: ProductDetailInteractorContract?
    private let router: ProductDetailRouterContract?
    internal var productViewModel: ProductViewModel
    public var quantity: Int {
        didSet {
            DispatchQueue.main.async {
                self.setupView()
            }
        }
    }
    public var totalPrice: Double {
        productViewModel.finalPrice(quantityToBuy: quantity)
    }
    
    init(wireframe: ProductDetailWireframe, interactor: ProductDetailInteractorContract, router: ProductDetailRouterContract, productViewModel: ProductViewModel) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.router = router
        self.productViewModel = productViewModel
        self.quantity = productViewModel.quantity
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
            productViewModel.quantity = quantity
        }
    }
    
    func substractOne() {
        if quantity > 0 {
            quantity -= 1
            productViewModel.quantity = quantity
        }
    }
    
    func closeModalScreen(_ viewController: UIViewController) {
        router?.closeModalScreen(viewController)
    }
    
    func postSelectedItems() {
        let newQuantityNotificationObject = ["code" : productViewModel.code, "quantity": quantity] as [String : Any]
        NotificationCenter.default.post(name: productNotification, object: nil, userInfo: newQuantityNotificationObject)
    }
}

private extension ProductDetailPresenter {
    func setupView() {
        DispatchQueue.main.async {
            self.view?.configure(with: self.productViewModel)
        }
    }
}
