//
//  HelpersAndConstants.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 27/2/23.
//

import XCTest
@testable import CabifyProducts

let defaultPromotion = Promotion(type: .other, amountToBuy: 0, amountFree: nil, priceWithDiscount: 0.0)
let defaultProductViewModel = ProductViewModel(code: "", name: "", price: 0.0, detail: "", imageName: "", promotion: defaultPromotion)

let tshirtPromotion = Promotion(type: .bulk, amountToBuy: 3, amountFree: nil, priceWithDiscount: 19.0)
let tshirtProductViewModel = ProductViewModel(code: "TSHIRT", name: "T-shirt", price: 20.0, detail: "", imageName: "", promotion: tshirtPromotion)
