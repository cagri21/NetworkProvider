//
//  ProductsResponse.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation

public protocol ProductDisplayable {
    var id: Int { get }
    var title: String { get }
    var imageURL: String { get }
    var price: Double { get }
    var instantDiscountPrice: Double? { get }
}

// MARK: - API Response
public struct ProductsResponse: Codable {
    public let page: String
    public let nextPage: String?
    public let published_at: String
    public let sponsoredProducts: [SponsoredProduct]?
    public let products: [Product]
}

public struct SponsoredProduct: Codable, ProductDisplayable {
    public let id: Int
    public let title: String
    public let image: String
    public let price: Double
    public let instantDiscountPrice: Double?
    public let rate: Double?

    public var imageURL: String { image }
}

public struct Product: Codable, ProductDisplayable {
    public let id: Int
    public let title: String
    public let image: String
    public let price: Double
    public let instantDiscountPrice: Double?
    public let rate: Double?
    public let sellerName: String?

    public var imageURL: String { image }
}
