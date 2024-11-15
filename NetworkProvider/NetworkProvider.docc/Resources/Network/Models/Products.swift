//
//  ProductsResponse.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation

public struct ProductsResponse: Codable {
    public let page: String?
    public let nextPage: String?
    public let published_at: String?
}
