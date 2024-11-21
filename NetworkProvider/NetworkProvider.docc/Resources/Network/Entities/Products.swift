//
//  ProductsResponse.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation
import UIKit
import SDWebImage

// MARK: - ProductDisplayable Protocol
public protocol BaseProductDisplayable: Codable {
    var title: String { get }
    var price: Double { get }
    var instantDiscountPrice: Double? { get }
    var rate: Double? { get }
}


public protocol ProductDisplayable: BaseProductDisplayable {
    var id: Int { get }
    var title: String { get }
    var image: String { get }
    var price: Double { get }
    var instantDiscountPrice: Double? { get }
    var rate: Double? { get }
    var imageData: UIImage? { get set }

    func getImage(completion: @escaping (UIImage?) -> Void)
}

// Default implementation for getImage
public extension ProductDisplayable {
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: image) else {
            completion(nil)
            return
        }

        SDWebImageDownloader.shared.downloadImage(with: url) { image, _, _, _ in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}

// MARK: - ProductsResponse
public struct ProductsResponse: Codable {
    public let page: String
    public let nextPage: String?
    public let publishedAt: String
    public let sponsoredProducts: [SponsoredProduct]?
    public let products: [Product]

    private enum CodingKeys: String, CodingKey {
        case page
        case nextPage
        case publishedAt = "published_at"
        case sponsoredProducts
        case products
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(String.self, forKey: .page)
        nextPage = try container.decodeIfPresent(String.self, forKey: .nextPage)
        publishedAt = try container.decode(String.self, forKey: .publishedAt)
        sponsoredProducts = try container.decodeIfPresent([SponsoredProduct].self, forKey: .sponsoredProducts)
        products = try container.decode([Product].self, forKey: .products)
    }
}

// MARK: - SponsoredProduct
public struct SponsoredProduct: ProductDisplayable {
    public var id: Int
    public var title: String
    public var image: String
    public var price: Double
    public var instantDiscountPrice: Double?
    public var rate: Double?
    public var imageData: UIImage? = nil // Exclude this from decoding

    private enum CodingKeys: String, CodingKey {
        case id, title, image, price, instantDiscountPrice, rate
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        price = try container.decode(Double.self, forKey: .price)
        instantDiscountPrice = try container.decodeIfPresent(Double.self, forKey: .instantDiscountPrice)
        rate = try container.decodeIfPresent(Double.self, forKey: .rate)
        imageData = nil // Explicitly set as nil since it shouldn't be decoded
    }
}

// MARK: - Product
public struct Product: ProductDisplayable {
    public var id: Int
    public var title: String
    public var image: String
    public var price: Double
    public var instantDiscountPrice: Double?
    public var rate: Double?
    public var sellerName: String
    public var imageData: UIImage? = nil // Exclude this from decoding

    private enum CodingKeys: String, CodingKey {
        case id, title, image, price, instantDiscountPrice, rate, sellerName
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        price = try container.decode(Double.self, forKey: .price)
        instantDiscountPrice = try container.decodeIfPresent(Double.self, forKey: .instantDiscountPrice)
        rate = try container.decodeIfPresent(Double.self, forKey: .rate)
        sellerName = try container.decode(String.self, forKey: .sellerName)
        imageData = nil // Explicitly set as nil since it shouldn't be decoded
    }
}
