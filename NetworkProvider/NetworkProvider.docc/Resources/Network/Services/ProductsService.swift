//
//  UserService.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation

public class ProductsService: ProductsServiceProtocol {

    public typealias RetrieveProductResult = ((Swift.Result<ProductsResponse, ExceptionHandler>) -> Void)

    private let decoder: JSONDecoder = JSONDecoder()

    public init() {
        decoder.dateDecodingStrategy = .formatted(.server)
    }

    // MARK: - Action Plans of specific indicator message and risk object
    public func retrieveProducts(page: Int = 1, parameters: [URLQueryItem]?, completion: @escaping RetrieveProductResult) {
        NetworkManager.sharedInstance.fetchData(apiRequest: ProductsRouter.products(page.description)) { result in
            switch result {
            case .success(let data):
                do {
                    let products: ProductsResponse = try self.decoder.decode(ProductsResponse.self, from: data)
                    completion(.success(products))
                } catch {
                    completion(.failure(ExceptionHandler.invalidFormat))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

public protocol ProductsServiceProtocol {
    func retrieveProducts(page: Int, parameters: [URLQueryItem]?, completion: @escaping ((Swift.Result<ProductsResponse, ExceptionHandler>) -> Void))
}
