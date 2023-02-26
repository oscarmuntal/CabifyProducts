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
    var products: [ProductViewModel] { get }
}

protocol CheckoutInteractorContract {}

protocol CheckoutRouterContract {}

