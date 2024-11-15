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

    var method: HTTPMethod {
        switch self {
        case .products:
            return .get
        }
    }

    func asURLRequest() throws -> URLRequest {
        var url: URL!

        switch self {
        case let .products(page):

            url = Endpoints.products(page).url
        }

        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(30)

        return try URLEncoding.default.encode(request, with: nil)
    }

    // MARK: - Master Data Query Items
    private func defaultIncidentsQueryItems(_ page: Int) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []

        return queryItems
    }

}
