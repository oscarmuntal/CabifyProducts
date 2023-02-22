//
//  ProductsContract.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Foundation

protocol ProductsRouterContract {}

protocol ProductsWireframe {}

protocol ProductsViewContract {}

protocol ProductsPresenterContract {
    var view: ProductsViewContract? { get set }
}

protocol ProductsInteractorContract {}
