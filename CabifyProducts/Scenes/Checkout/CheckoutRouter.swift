//
//  CheckoutRouter.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 26/2/23.
//

import Foundation

class CheckoutRouter: CheckoutRouterContract {
    private let wireframe: CheckoutWireframe
    
    init(wireframe: CheckoutWireframe) {
        self.wireframe = wireframe
    }
}
