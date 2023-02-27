//
//  ProductsPresenter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Combine
import UIKit

class ProductsPresenter {
    public let interactor: ProductsInteractorContract
    public let router: ProductsRouterContract
    private var cancellables: Set<AnyCancellable> = []
    
    init(interactor: ProductsInteractorContract, router: ProductsRouterContract) {
        self.interactor = interactor
        self.router = router
        NotificationCenter.default.addObserver(self, selector: #selector(handleItemPriceNotification(_:)), name: productNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleResetItemsNotification), name: resetItemsNotification, object: nil)
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
}

private extension ProductsPresenter {
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
        configureCheckoutButton(products: products)
    }
    
    func configureCheckoutButton(products: [ProductViewModel]) {
        let totalProductsToBuy = products.reduce(0) { $0 + $1.quantity }
        view?.enableCheckoutButton(enabled: totalProductsToBuy > 0)
    }
    
    @objc func handleResetItemsNotification() {
        let newProducts = products.map { (product: ProductViewModel) -> ProductViewModel in
            var newProduct = product
            newProduct.quantity = 0
            return newProduct
        }
        products = newProducts
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
        router.didSelect(productViewModel: products[indexPath.row], from: viewController)
    }
    
    func checkoutTapped() {
        router.navigateToCheckout(products: products)
    }
    
    func configureCheckoutButton() {
        configureCheckoutButton(products: products)
    }
}

private extension ProductsPresenter {
    func loadProducts() {
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
