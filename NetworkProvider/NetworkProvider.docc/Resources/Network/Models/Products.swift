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
    var image: String { get }
    var price: Double { get }
    var instantDiscountPrice: Double? { get }
    var rate: Double { get }
    var imageData: UIImage? { get set } // Mutable property for storing the image
}

// MARK: - API Response
public struct ProductsResponse: Decodable {
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

public struct SponsoredProduct: Decodable, ProductDisplayable {
    public var id: Int
    public var title: String
    public var image: String
    public var price: Double
    public var instantDiscountPrice: Double?
    public var rate: Double

    public var imageData: UIImage?

    // Shared GCD queue for background tasks
    private static let backgroundQueue = DispatchQueue(label: "com.app.imageDownloadQueue", qos: .background)
    
    private enum ProductCodingKeys: String, CodingKey {
        case id, title, image, price, instantDiscountPrice, rate
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        price = try container.decode(Double.self, forKey: .price)
        instantDiscountPrice = try container.decodeIfPresent(Double.self, forKey: .instantDiscountPrice)
        rate = try container.decode(Double.self, forKey: .rate)
    }
    
    
    public func fetchImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: image) else {
            completion(nil)
            return
        }

            // Use SDWebImage for downloading in a separate function
        SDWebImageDownloader.shared.downloadImage(with: url) { image, _, _, _ in
        DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}

public struct Product: Decodable, ProductDisplayable {
    public var id: Int
    public var title: String
    public var image: String
    public var price: Double
    public var instantDiscountPrice: Double?
    public var rate: Double
    public var sellerName: String
    public var imageData: UIImage?
    
    private enum ProductCodingKeys: String, CodingKey {
        case id, title, image, price, instantDiscountPrice, rate, sellerName
    }

    // Shared GCD queue for background tasks
    private static let backgroundQueue = DispatchQueue(label: "com.app.imageDownloadQueue", qos: .background)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        price = try container.decode(Double.self, forKey: .price)
        instantDiscountPrice = try container.decodeIfPresent(Double.self, forKey: .instantDiscountPrice)
        rate = try container.decode(Double.self, forKey: .rate)
        sellerName = try container.decode(String.self, forKey: .sellerName)
    }
    
    public func fetchImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: image) else {
            completion(nil)
            return
        }

            // Use SDWebImage for downloading in a separate function
        SDWebImageDownloader.shared.downloadImage(with: url) { image, _, _, _ in
        DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}


