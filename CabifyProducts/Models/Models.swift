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
    var toCellViewModel: ProductCellViewModel {
        .init(name: name, price: price, promotion: promotionByProduct(with: code))
    }
    
    func promotionByProduct(with name: String) -> String {
        switch name.uppercased() {
        case "VOUCHER": return "2-for-1 promotion!"
        case "TSHIRT", "T-SHIRT": return "Buy 3 or more and you'll get a discount!"
        case "MUG": return "Wonderful and excusive mugs, designed by special artists"
        default: return ""
        }
    }
}
