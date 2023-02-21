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
