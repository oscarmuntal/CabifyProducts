//
//  ProductsPresenter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Foundation
import Combine

class ProductsPresenter: ProductsPresenterContract {
    public let wireframe: ProductsWireframe?
    public let interactor: ProductsInteractorContract?
    public let router: ProductsRouterContract?
    private var cancellables: Set<AnyCancellable> = []
    
    init(wireframe: ProductsWireframe, interactor: ProductsInteractorContract, router: ProductsRouterContract) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.router = router
    }
    
    public var view: ProductsViewContract? {
        didSet {
            loadProducts()
        }
    }
}

private extension ProductsPresenter {
    func loadProducts() {
        guard let interactor = interactor else { return }
        interactor.fetchProducts()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { productsDataModel in
                print(productsDataModel.products)
            }.store(in: &cancellables)
    }
}
