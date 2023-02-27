//
//  CheckoutRouter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 26/2/23.
//

import Foundation
import UIKit

class CheckoutRouter {
    private let wireframe: CheckoutWireframe
    
    init(wireframe: CheckoutWireframe) {
        self.wireframe = wireframe
    }
}

extension CheckoutRouter: CheckoutRouterContract {
    func presentPurchaseAlert(from viewController: UIViewController) {
        let alert = UIAlertController(title: "Purchase completed!! 🎉",
                                      message: "Congratulations, your purchases will arrive at your home in the next 3-5 business days. ",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            viewController.navigationController?.popViewController(animated: true)
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
