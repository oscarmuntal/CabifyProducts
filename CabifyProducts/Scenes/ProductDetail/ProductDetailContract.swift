//
//  ProductDetailContract.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit
import Combine

protocol ProductDetailWireframe {}

protocol ProductDetailViewContract {
    func setQuantity(with quantity: Int)
    func configure(with productViewModel: ProductViewModel)
}

protocol ProductDetailPresenterContract {
    var view: ProductDetailViewContract? { get set }
    var productViewModel: ProductViewModel { get set }
    var quantity: Int { get set }
    var totalPrice: Double { get }
    func addOne()
    func substractOne()
    func closeModalScreen(_ viewController: UIViewController)
    func postSelectedItemsAndTotalPrice()
}

protocol ProductDetailInteractorContract {}
