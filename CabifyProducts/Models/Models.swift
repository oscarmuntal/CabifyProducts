//
//  Models.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 21/2/23.
//

import Foundation

struct Products: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    let code: String
    let name: String
    let price: Double
}

extension Product {
    var toViewModel: ProductViewModel {
        .init(name: name, price: price, detail: detailByProduct(with: code), imageName: code.lowercased(), promotion: getPromotion(by: code))
    }
    
    func detailByProduct(with code: String) -> String {
        switch code.uppercased() {
        case "VOUCHER": return "2-for-1 promotion!"
        case "TSHIRT", "T-SHIRT": return "Buy 3 or more and you'll get a discount!"
        case "MUG": return "Wonderful and excusive mugs, designed by special artists"
        default: return ""
        }
    }
    
    func getPromotion(by code: String) -> Promotion {
        switch code.uppercased() {
        case "VOUCHER":
            return Promotion(type: .buyXGetZFree, amountToBuy: 2, amountFree: 1, priceWithDiscount: nil)
        case "TSHIRT", "T-SHIRT":
            return Promotion(type: .bulk, amountToBuy: 3, amountFree: nil, priceWithDiscount: 19.0)
        default:
            return Promotion(type: .other, amountToBuy: 0, amountFree: nil, priceWithDiscount: nil)
        }
    }
}
