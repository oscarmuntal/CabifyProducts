//
//  ProductDetailRouter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 23/2/23.
//

import Foundation
import UIKit

protocol ProductDetailRouterContract {
    func closeModalScreen(_ viewController: UIViewController)
}

class ProductDetailRouter: ProductDetailRouterContract {
    func closeModalScreen(_ viewController: UIViewController) {
        viewController.dismiss(animated: true)
    }
}
