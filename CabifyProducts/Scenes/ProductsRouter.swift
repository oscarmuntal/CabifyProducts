//
//  ProductsRouter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//


class ProductsRouter {
    private let wireframe: ProductsWireframe
    
    init(wireframe: ProductsWireframe) {
        self.wireframe = wireframe
    }
}

extension ProductsRouter: ProductsRouterContract {}
