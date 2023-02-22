//
//  ProductDetailContract.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Combine

protocol ProductDetailWireframe {}

protocol ProductDetailViewContract {
    func configure(with productViewModel: ProductViewModel)
}

protocol ProductDetailPresenterContract {
    var view: ProductDetailViewContract? { get set }
    var productViewModel: ProductViewModel { get set }
}

protocol ProductDetailInteractorContract {}
