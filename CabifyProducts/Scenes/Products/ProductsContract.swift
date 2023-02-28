//
//  ProductsContract.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit
import Combine

protocol ProductsWireframe: ProductDetailOpener, CheckoutOpener {}

protocol ProductsViewContract: ReloadAwareView {
    func enableCheckoutButton(enabled: Bool)
}

protocol ProductsPresenterContract {
    var view: ProductsViewContract? { get set }
    func numProducts() -> Int
    func cellViewModel(at indexPath: IndexPath) -> ProductViewModel
    func didSelectItem(at indexPath: IndexPath, from viewController: UIViewController)
    func checkoutTapped()
    func configureCheckoutButton()
}

protocol ProductsInteractorContract {
    func fetchProducts() -> AnyPublisher<Products, CabifyError>
}

protocol ProductsRouterContract {
    func didSelect(productViewModel: ProductViewModel, from viewController: UIViewController)
    func navigateToCheckout(products: [ProductViewModel])
}
