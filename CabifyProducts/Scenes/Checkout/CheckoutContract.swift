//
//  CheckoutContract.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 26/2/23.
//

import UIKit

protocol CheckoutWireframe {}

protocol CheckoutViewContract {}

protocol CheckoutPresenterContract {
    var view: CheckoutViewContract? { get set }
    var totalPrice: Double { get }
    var products: [ProductViewModel] { get }
    func payButtonTapped()
}

protocol CheckoutInteractorContract {}

protocol CheckoutRouterContract {
    func presentPurchaseAlert(from viewController: UIViewController)
}

