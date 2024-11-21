//
//  Product.swift
//  
//
//  Created by Çağrı Yörükoğlu on 21.11.2024.
//

public struct ProductResponse: BaseProductDisplayable, Codable {
    public var title: String
    public let images: [String]
    public var description: String
    public var price: Double
    public var instantDiscountPrice: Double?
    public var rate: Double?
    public var sellerName: String

    private enum CodingKeys: String, CodingKey {
        case title, images, description, price, instantDiscountPrice, rate, sellerName
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        price = try container.decode(Double.self, forKey: .price)
        instantDiscountPrice = try container.decodeIfPresent(Double.self, forKey: .instantDiscountPrice)
        rate = try container.decodeIfPresent(Double.self, forKey: .rate)
        sellerName = try container.decode(String.self, forKey: .sellerName)
        description = try container.decode(String.self, forKey: .description)
        images = try container.decode([String].self, forKey: .images)
    }
}
