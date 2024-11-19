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
public protocol ProductDisplayable: Codable {
    var id: Int { get }
    var title: String { get }
    var image: String { get }
    var price: Double { get }
    var instantDiscountPrice: Double { get }
    var rate: Double { get }
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

    enum CodingKeys: String, CodingKey {
        case page
        case nextPage
        case publishedAt = "published_at"
        case sponsoredProducts
        case products
    }
}

// MARK: - SponsoredProduct
public struct SponsoredProduct: ProductDisplayable {
    public var id: Int
    public var title: String
    public var image: String
    public var price: Double
    public var instantDiscountPrice: Double
    public var rate: Double
    public var imageData: UIImage? = nil // Exclude this from decoding

    // Define CodingKeys to exclude `imageData` from decoding
    private enum CodingKeys: String, CodingKey {
        case id, title, image, price, instantDiscountPrice, rate
    }
}

// MARK: - Product
public struct Product: ProductDisplayable {
    public var id: Int
    public var title: String
    public var image: String
    public var price: Double
    public var instantDiscountPrice: Double
    public var rate: Double
    public var sellerName: String
    public var imageData: UIImage? = nil // Exclude this from decoding

    // Define CodingKeys to exclude `imageData` from decoding
    private enum CodingKeys: String, CodingKey {
        case id, title, image, price, instantDiscountPrice, rate, sellerName
    }
}
