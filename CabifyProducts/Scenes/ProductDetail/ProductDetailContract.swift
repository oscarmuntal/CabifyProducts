//
//  ProductDetailContract.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Combine

protocol ProductDetailWireframe {}

protocol ProductDetailViewContract {
    func setQuantity(with quantity: Int)
    func configure(with productViewModel: ProductViewModel)
}

protocol ProductDetailPresenterContract {
    var view: ProductDetailViewContract? { get set }
    var productViewModel: ProductViewModel { get set }
    func addOne()
    func substractOne()
}

protocol ProductDetailInteractorContract {}
