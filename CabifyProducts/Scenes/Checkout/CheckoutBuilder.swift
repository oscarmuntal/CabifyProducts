//
//  CheckoutBuilder.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 26/2/23.
//

import UIKit

protocol CheckoutBuilderContract {
    var wireframe: CheckoutWireframe { get }
    func buildViewController() -> UIViewController
    func buildPresenter(products: [ProductViewModel]) -> CheckoutPresenterContract
    func buildInteractor() -> CheckoutInteractorContract
    func buildRouter() -> CheckoutRouterContract
}

extension CheckoutBuilderContract {
    func buildPresenter(products: [ProductViewModel]) -> CheckoutPresenterContract {
        CheckoutPresenter(wireframe: wireframe, interactor: buildInteractor(), router: buildRouter(), products: products)
    }
    
    func buildInteractor() -> CheckoutInteractorContract {
        CheckoutInteractor()
    }
    
    func buildRouter() -> CheckoutRouterContract {
        CheckoutRouter(wireframe: wireframe)
    }
}

class CheckoutBuilder: CheckoutBuilderContract {
    internal let wireframe: CheckoutWireframe
    internal let products: [ProductViewModel]
    
    init(wireframe: CheckoutWireframe, products: [ProductViewModel]) {
        self.wireframe = wireframe
        self.products = products
    }
    
    func buildViewController() -> UIViewController {
        let view = CheckoutView.createFromStoryboard()
        view.presenter = buildPresenter(products: products)
        return view
    }
    
}
