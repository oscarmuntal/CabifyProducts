//
//  ProductsInteractor.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Foundation
import Combine

class ProductsInteractor {
    private let productsProvider: ProductsProviderContract
    
    init(productsProvider: ProductsProviderContract = ProductsProvider()) {
        self.productsProvider = productsProvider
    }
}

extension ProductsInteractor: ProductsInteractorContract {
    func fetchProducts() -> AnyPublisher<Products, Error> {
        productsProvider.fetchProducts()
    }
}
