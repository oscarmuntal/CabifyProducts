//
//  ProductDetailContract.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Combine

protocol ProductDetailWireframe {}

protocol ProductDetailViewContract {
    func configure(with product: Product)
}

protocol ProductDetailPresenterContract {
    var view: ProductDetailViewContract? { get set }
    var product: Product { get set }
}

protocol ProductDetailInteractorContract {}
