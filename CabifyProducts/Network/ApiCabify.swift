//
//  ApiCabify.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 21/2/23.
//

import Foundation

class ApiCabify {
    public static let shared = ApiCabify()
    
    func retrieveProducts() {
        let urlSession = URLSession.shared
        let url = URL(string: "https://gist.githubusercontent.com/palcalde/6c19259bd32dd6aafa327fa557859c2f/raw/ba51779474a150ee4367cda4f4ffacdcca479887/Products.json")
        
        urlSession.dataTask(with: url!) { data, response, error in
            if let _ = error {
                print("Error")
            }
            if let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let productsDataModel = try! JSONDecoder().decode(Products.self, from: data)
                print(productsDataModel.products)
            }
        }.resume()
    }
}
