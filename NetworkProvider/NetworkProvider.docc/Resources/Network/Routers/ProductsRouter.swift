//
//  ProductRouter.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Alamofire
import Foundation

enum ProductsRouter: URLRequestConvertible {

    case products(String)
    case product(Int)

    var method: HTTPMethod {
        switch self {
        case .products:
            return .get
        case .product(_):
            return .get
        }
    }

    func asURLRequest() throws -> URLRequest {
        var url: URL!

        switch self {
        case let .products(page):
            url = Endpoints.products(page).url
        case let .product(productID):
            let queryItems: [URLQueryItem] = defaultProductQueryItems(productID)
            url = Endpoints.product(queryItems).url
        }

        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(30)

        return try URLEncoding.default.encode(request, with: nil)
    }

    // MARK: - Product Data Query Items
    private func defaultProductQueryItems(_ productID: Int) -> [URLQueryItem] {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "productId", value: "\(productID)"),
        ]
        return queryItems
    }

}
