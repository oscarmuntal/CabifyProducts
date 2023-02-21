//
//  BundleExtensions.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 21/2/23.
//

import Foundation

extension Bundle {
    var apiUrl: String { object(forInfoDictionaryKey: "API_URL") as! String }
}
