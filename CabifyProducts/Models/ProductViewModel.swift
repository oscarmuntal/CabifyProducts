//
//  ProductCellViewModel.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Foundation

struct ProductViewModel {
    let code: String
    let name: String
    let price: Double
    let detail: String
    let imageName: String
    let promotion: Promotion
    var quantity: Int = 0
    
    var finalPrice: Double {
        switch promotion.type {
        case .buyXGetZFree:
            let promotions = quantity/promotion.amountToBuy
            let totalFreeItems = promotions * (promotion.amountFree ?? 0)
            let totalItemsToPay = quantity - totalFreeItems
            return Double(totalItemsToPay) * price
        case .bulk:
            if quantity >= promotion.amountToBuy {
                return Double(quantity) * (promotion.priceWithDiscount ?? 0.0)
            }
            return Double(quantity) * price
        default:
            return Double(quantity) * price
        }
    }
}

struct Promotion {
    let type: PromotionType
    let amountToBuy: Int
    let amountFree: Int?
    let priceWithDiscount: Double?
}

enum PromotionType {
    case buyXGetZFree
    case bulk
    case other
}
