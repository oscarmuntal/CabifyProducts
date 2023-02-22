//
//  ProductsContract.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit
import Combine

protocol ProductsWireframe: ProductDetailOpener {}

protocol ProductsViewContract: ReloadAwareView {}

protocol ProductsPresenterContract {
    var view: ProductsViewContract? { get set }
    func numProducts() -> Int
    func cellViewModel(at indexPath: IndexPath) -> ProductViewModel
    func didSelectItem(at indexPath: IndexPath, from viewController: UIViewController)
}

protocol ProductsInteractorContract {
    func fetchProducts() -> AnyPublisher<Products, Error>
}

protocol ProductsRouterContract {
    func didSelect(productViewModel: ProductViewModel, from viewController: UIViewController)
}
