//
//  Endpoints.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation

struct Endpoints {

    let path: String

    var queryItems: [URLQueryItem]?

    var url: URL? {
        var components: URLComponents = URLComponents()
        components.scheme = "https"
        components.host = UserDefaults.activeUrl
        components.path = path
        components.queryItems = queryItems
        return components.url
    }

    static func products(_ page: String) -> Endpoints {
        Endpoints(
            path: "/listing/\(page)"
        )
    }
    
    static func product(_ queryItems: [URLQueryItem]) -> Endpoints {
        Endpoints(
            path: "/product", queryItems: queryItems
        )
    }
}
