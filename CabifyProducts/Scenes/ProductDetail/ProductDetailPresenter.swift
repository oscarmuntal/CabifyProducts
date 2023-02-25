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
    
    func closeModalScreen(_ viewController: UIViewController) {
        router?.closeModalScreen(viewController)
    }
    
    func postSelectedItemsAndTotalPrice() {
        let quantityNotificationName = Notification.Name("selected items from \(productViewModel.name)")
        let quantityNotificationObject = ["quantity": quantity]
        NotificationCenter.default.post(name: quantityNotificationName, object: quantity, userInfo: quantityNotificationObject)
        
        let totalPriceNotificationObject = ["item" : productViewModel.name, "totalPrice" : totalPrice] as [String : Any]
        NotificationCenter.default.post(name: totalPriceNotificationName, object: nil, userInfo: totalPriceNotificationObject)
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
