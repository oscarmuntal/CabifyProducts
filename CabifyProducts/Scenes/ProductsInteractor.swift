//
//  ProductsInteractor.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Foundation

class ProductsInteractor: ProductsInteractorContract {
    private let productsProvider: ProductsProviderContract
    
    init(productsProvider: ProductsProviderContract = ProductsProvider()) {
        self.productsProvider = productsProvider
    }
}
