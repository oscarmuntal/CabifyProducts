//
//  ProductsPresenter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Foundation

class ProductsPresenter: ProductsPresenterContract {
    public let wireframe: ProductsWireframe?
    public let interactor: ProductsInteractorContract?
    public let router: ProductsRouterContract?
    public var view: ProductsViewContract?
    
    init(wireframe: ProductsWireframe, interactor: ProductsInteractorContract, router: ProductsRouterContract) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.router = router
    }
}
