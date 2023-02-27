//
//  UITableViewMock.swift
//  CabifyProductsTests
//
//  Created by Òscar Muntal on 27/2/23.
//

import XCTest
@testable import CabifyProducts

class UITableViewMock: UITableView {
    var dequeueReusableCellWithIdentifierCalled = false
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCellWithIdentifierCalled = true
        if identifier == "productCell" {
            return ProductsTableViewCellMock(style: .default, reuseIdentifier: "productCell")
        } else {
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
}
