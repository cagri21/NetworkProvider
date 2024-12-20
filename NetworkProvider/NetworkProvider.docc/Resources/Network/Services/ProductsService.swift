//
//  UserService.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation

public class ProductsService: ProductsServiceProtocol {

    public typealias RetrieveProductsResult = ((Swift.Result<ProductsResponse, ExceptionHandler>) -> Void)
    public typealias RetrieveProductResult = ((Swift.Result<ProductResponse, ExceptionHandler>) -> Void)

    private let decoder: JSONDecoder = JSONDecoder()

    public init() {
        decoder.dateDecodingStrategy = .formatted(.server)
    }

    // MARK: - Action Plans of specific indicator message and risk object
    public func fetchProducts(page: Int = 1, parameters: [URLQueryItem]?, completion: @escaping RetrieveProductsResult) {
        NetworkManager.sharedInstance.fetchData(apiRequest: ProductsRouter.products(page.description)) { result in
            switch result {
            case .success(let data):
                do {
                    let products: ProductsResponse = try self.decoder.decode(ProductsResponse.self, from: data)
                    completion(.success(products))
                } catch {
                    completion(.failure(ExceptionHandler.unwrappingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func fetchProduct(productID: Int, parameters: [URLQueryItem]?, completion: @escaping RetrieveProductResult) {
        NetworkManager.sharedInstance.fetchData(apiRequest: ProductsRouter.product(productID)) { result in
            switch result {
            case .success(let data):
                do {
                    let product: ProductResponse = try self.decoder.decode(ProductResponse.self, from: data)
                    completion(.success(product))
                } catch {
                    completion(.failure(ExceptionHandler.unwrappingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

public protocol ProductsServiceProtocol {
    func fetchProducts(page: Int, parameters: [URLQueryItem]?, completion: @escaping ((Swift.Result<ProductsResponse, ExceptionHandler>) -> Void))
    func fetchProduct(productID: Int, parameters: [URLQueryItem]?, completion: @escaping ((Swift.Result<ProductResponse, ExceptionHandler>) -> Void))
}
