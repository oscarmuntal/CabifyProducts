//
//  ProductsBuilder.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit

protocol ProductsBuilderContract: Builder {
    var wireframe: ProductsWireframe { get }
    func buildViewController() -> UIViewController
    func buildPresenter() -> ProductsPresenterContract
    func buildInteractor() -> ProductsInteractorContract
    func buildRouter() -> ProductsRouterContract
}

extension ProductsBuilderContract {
    func buildPresenter() -> ProductsPresenterContract {
        ProductsPresenter(interactor: buildInteractor(), router: buildRouter())
    }

    func buildInteractor() -> ProductsInteractorContract {
        ProductsInteractor()
    }
    
    func buildRouter() -> ProductsRouterContract {
        ProductsRouter(wireframe: wireframe)
    }
}

class ProductsBuilder: ProductsBuilderContract {
    internal let wireframe: ProductsWireframe
    
    init(wireframe: ProductsWireframe) {
        self.wireframe = wireframe
    }
    
    func buildViewController() -> UIViewController {
        let view = ProductsView.createFromStoryboard()
        view.presenter = buildPresenter()
        return view
    }
}
