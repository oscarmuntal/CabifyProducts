//
//  ApiCabify.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 21/2/23.
//

import Foundation

protocol ApiCall {
    var baseUrl: String? { get }
    var extraHeaders: [String: String]? { get }
    var path: String { get }
    var params: [String: String]? { get }
    func buildURL() -> URL?
}

enum ApiCabify: ApiCall {
    case products
    
    var baseUrl: String? { Bundle.main.apiUrl }
    var extraHeaders: [String : String]? { nil }
    var path: String {
        switch self {
        case .products: return "/palcalde/6c19259bd32dd6aafa327fa557859c2f/raw/ba51779474a150ee4367cda4f4ffacdcca479887/Products.json"
        }
    }
    var params: [String : String]? { nil }
    
    func buildURL() -> URL? {
        guard let baseUrl = baseUrl else { return nil }
        return URL(string: baseUrl + path)
    }
}

class ApiRouter {
    public static let shared = ApiRouter()
    
    func retrieveProducts(api: ApiCabify) {
        guard let url = api.buildURL() else {
            print("Wrong URL")
            return
        }
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            if let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let productsDataModel = try JSONDecoder().decode(Products.self, from: data)
                    print(productsDataModel.products)
                } catch (let error) {
                    print(error)
                }
            }
        }.resume()
    }
}
