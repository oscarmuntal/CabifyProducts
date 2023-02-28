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
let tshirtProductViewModel = ProductViewModel(code: "TSHIRT", name: "T-shirt", price: 20.0, detail: "T-shirt detail 1", imageName: "tshirt", promotion: tshirtPromotion, quantity: 0)

let voucherPromotion = Promotion(type: .buyXGetZFree, amountToBuy: 2, amountFree: 1, priceWithDiscount: nil)
let voucherProductViewModel = ProductViewModel(code: "VOUCHER", name: "Voucher's name", price: 5.0, detail: "2-for-1 promotion!", imageName: "voucher", promotion: voucherPromotion, quantity: 0)

let tshirtQuantityThreeProductViewModel = ProductViewModel(code: "TSHIRT", name: "T-shirt", price: 20.0, detail: "T-shirt detail 2", imageName: "tshirt", promotion: tshirtPromotion, quantity: 3)

let defaultProduct = Product(code: "MUG", name: "Awesome Mug", price: 7.5)
let defaultProductsResponse = Products(products: [defaultProduct])


