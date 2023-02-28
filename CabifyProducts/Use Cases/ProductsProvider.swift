//
//  ProductsProvider.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Foundation
import Combine

protocol ProductsProviderContract {
    func fetchProducts() -> AnyPublisher<Products, CabifyError>
}

class ProductsProvider: ProductsProviderContract {
    private let apiRouter: ApiRouting
    
    init(apiRouter: ApiRouting = ApiRouter()) {
        self.apiRouter = apiRouter
    }
    public func fetchProducts() -> AnyPublisher<Products, CabifyError> {
        apiRouter.requestDecodablePublisher(api: .products)
    }
}
