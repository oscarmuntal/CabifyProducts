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

protocol ProductsViewContract {}

protocol ProductsPresenterContract {
    var view: ProductsViewContract? { get set }
}

protocol ProductsInteractorContract {
    func fetchProducts() -> AnyPublisher<Products, Error>
}
