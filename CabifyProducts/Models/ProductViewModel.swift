//
//  ProductCellViewModel.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import Foundation
import CoreText

struct ProductViewModel {
    let code: String
    let name: String
    let price: Double
    let detail: String
    let imageName: String
    let promotion: Promotion
    var quantity: Int = 0
    
    func finalPrice(quantityToBuy: Int) -> Double {
        switch promotion.type {
        case .buyXGetZFree:
            let promotions = quantityToBuy/promotion.amountToBuy
            let totalFreeItems = promotions * (promotion.amountFree ?? 0)
            let totalItemsToPay = quantityToBuy - totalFreeItems
            return Double(totalItemsToPay) * price
        case .bulk:
            if quantityToBuy >= promotion.amountToBuy {
                return Double(quantityToBuy) * (promotion.priceWithDiscount ?? 0.0)
            }
            return Double(quantityToBuy) * price
        default:
            return Double(quantityToBuy) * price
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
