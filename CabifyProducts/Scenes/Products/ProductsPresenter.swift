//
//  ProductsPresenter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Foundation
import Combine
import UIKit

struct Item {
    let name: String
    let quantity: Int
    let totalPrice: Double
}

class ProductsPresenter {
    public let wireframe: ProductsWireframe?
    public let interactor: ProductsInteractorContract?
    public let router: ProductsRouterContract?
    private var cancellables: Set<AnyCancellable> = []
    
    init(wireframe: ProductsWireframe, interactor: ProductsInteractorContract, router: ProductsRouterContract) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.router = router
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleItemPriceNotification(_:)), name: productNotification, object: nil)
    }
    
    public var view: ProductsViewContract? {
        didSet {
            loadProducts()
        }
    }
    
    internal var products = [ProductViewModel]() {
        didSet {
            view?.reload()
        }
    }
    
    @objc func handleItemPriceNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String : Any],
              let itemCode = userInfo["code"] as? String,
              let quantity = userInfo["quantity"] as? Int else { return }
        updateQuantity(for: itemCode, to: quantity, in: &products)
    }
    
    func updateQuantity(for productCode: String, to newQuantity: Int, in products: inout [ProductViewModel]) {
        if let index = products.firstIndex(where: { $0.code == productCode }) {
            products[index].quantity = newQuantity
        }
    }
    
}

extension ProductsPresenter: ProductsPresenterContract {
    func numProducts() -> Int {
        products.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ProductViewModel {
        products[indexPath.row]
    }
    
    func didSelectItem(at indexPath: IndexPath, from viewController: UIViewController) {
        router?.didSelect(productViewModel: products[indexPath.row], from: viewController)
    }
    
    func checkoutTapped() {
        router?.navigateToCheckout(products: products)
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
                productsDataModel.products.forEach { product in
                    self?.products.append(product.toViewModel)
                }
            }.store(in: &cancellables)
    }
}
