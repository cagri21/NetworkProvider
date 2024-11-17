//
//  ProductsResponse.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation
import UIKit
import SDWebImage

public protocol ProductDisplayable {
    var id: Int { get }
    var title: String { get }
    var imageURL: String { get }
    var price: Double { get }
    var instantDiscountPrice: Double? { get }
    var imageData: UIImage? { get set } // Mutable property for storing the image
}

// MARK: - API Response
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

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(String.self, forKey: .page)
        nextPage = try container.decodeIfPresent(String.self, forKey: .nextPage)
        let publishedAtRaw = try container.decode(String.self, forKey: .publishedAt)

        
        if let date = ISO8601DateFormatter().date(from: publishedAtRaw) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d/MM/yyyy"
            publishedAt = dateFormatter.string(from: date)
        } else {
            publishedAt = publishedAtRaw
        }

        sponsoredProducts = try container.decodeIfPresent([SponsoredProduct].self, forKey: .sponsoredProducts)
        products = try container.decode([Product].self, forKey: .products)
    }
}

public struct SponsoredProduct: Codable, ProductDisplayable {
    public let id: Int
    public let title: String
    public let image: String
    public let price: Double
    public let instantDiscountPrice: Double?
    public let rate: Double?

    public var imageData: UIImage?

    public var imageURL: String { image }

    // Shared GCD queue for background tasks
    private static let backgroundQueue = DispatchQueue(label: "com.app.imageDownloadQueue", qos: .background)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        price = try container.decode(Double.self, forKey: .price)
        instantDiscountPrice = try container.decodeIfPresent(Double.self, forKey: .instantDiscountPrice)
        rate = try container.decodeIfPresent(Double.self, forKey: .rate)

        // Asynchronously fetch the image during decoding
        Self.backgroundQueue.async {
            SDWebImageDownloader.shared.downloadImage(with: URL(string: self.imageURL)) { image, _, _, _ in
                DispatchQueue.main.async {
                    self.imageData = image
                }
            }
        }
    }
}

public struct Product: Codable, ProductDisplayable {
    public let id: Int
    public let title: String
    public let image: String
    public let price: Double
    public let instantDiscountPrice: Double?
    public let rate: Double?
    public let sellerName: String?

    public var imageData: UIImage?

    public var imageURL: String { image }

    // Shared GCD queue for background tasks
    private static let backgroundQueue = DispatchQueue(label: "com.app.imageDownloadQueue", qos: .background)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        price = try container.decode(Double.self, forKey: .price)
        instantDiscountPrice = try container.decodeIfPresent(Double.self, forKey: .instantDiscountPrice)
        rate = try container.decodeIfPresent(Double.self, forKey: .rate)
        sellerName = try container.decodeIfPresent(String.self, forKey: .sellerName)

        // Asynchronously fetch the image during decoding
        Self.backgroundQueue.async {
            SDWebImageDownloader.shared.downloadImage(with: URL(string: self.imageURL)) { image, _, _, _ in
                DispatchQueue.main.async {
                    self.imageData = image
                }
            }
        }
    }
}

internal enum ProductCodingKeys: String, CodingKey {
    case id, title, image, price, instantDiscountPrice, rate
}
