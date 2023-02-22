//
//  ProductsContract.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Foundation
import Combine

protocol ProductsRouterContract {}

protocol ProductsWireframe {}

protocol ProductsViewContract: ReloadAwareView {}

protocol ProductsPresenterContract {
    var view: ProductsViewContract? { get set }
    func numProducts() -> Int
    func cellViewModel(at indexPath: IndexPath) -> ProductCellViewModel
}

protocol ProductsInteractorContract {
    func fetchProducts() -> AnyPublisher<Products, Error>
}
