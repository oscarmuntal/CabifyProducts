//
//  ProductsPresenter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Foundation
import Combine
import UIKit

class ProductsPresenter {
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
    
    internal var products = [Product]() {
        didSet {
            view?.reload()
        }
    }
}

extension ProductsPresenter: ProductsPresenterContract {
    func numProducts() -> Int {
        products.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ProductViewModel {
        products[indexPath.row].toViewModel
    }
    
    func didSelectItem(at indexPath: IndexPath, from viewController: UIViewController) {
        let product = products[indexPath.row]
        router?.didSelect(productViewModel: product.toViewModel, from: viewController)
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
            } receiveValue: { [weak self] productsDataModel in
                print(productsDataModel.products)
                self?.products.append(contentsOf: productsDataModel.products)
            }.store(in: &cancellables)
    }
}
