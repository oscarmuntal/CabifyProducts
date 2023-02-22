//
//  ProductsRouter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit

class ProductsRouter {
    private let wireframe: ProductsWireframe
    
    init(wireframe: ProductsWireframe) {
        self.wireframe = wireframe
    }
}

extension ProductsRouter: ProductsRouterContract {
    func didSelect(product: Product, from viewController: UIViewController) {
        wireframe.openProductDetail(with: product, from: viewController)
    }
}
