//
//  ApiCabify.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 21/2/23.
//

import Foundation
import Combine

enum CabifyError: Error {
    case productsNotFound
    case other
}

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

protocol ApiRouting {
    func requestDecodable<T: Decodable>(api: ApiCabify, _ completion: @escaping (Result<T, CabifyError>) -> Void)
    func requestDecodablePublisher<T: Decodable>(api: ApiCabify) -> AnyPublisher<T, CabifyError>
}

class ApiRouter: ApiRouting {
    public static let shared = ApiRouter()
    
    func requestDecodable<T: Decodable>(api: ApiCabify, _ completion: @escaping (Result<T, CabifyError>) -> Void) {
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
                    let dataModel = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(dataModel))
                } catch (let error) {
                    print(error)
                }
            }
        }.resume()
    }
    
    func requestDecodablePublisher<T: Decodable>(api: ApiCabify) -> AnyPublisher<T, CabifyError> {
        Deferred {
            Future { [weak self] promise in
                self?.requestDecodable(api: api, { (result: Result<T, CabifyError>) in
                    switch result {
                    case .success(let data):
                        promise(.success(data))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                })
            }
        }.eraseToAnyPublisher()
    }
}
