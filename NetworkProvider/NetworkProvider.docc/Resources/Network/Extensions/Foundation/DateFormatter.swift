//
//  DateFormatter.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation

extension DateFormatter {

    private static let formatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

    public static let server: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = formatString
        return formatter
    }()

    public static let display: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = formatString
        formatter.dateStyle = .short
        return formatter
    }()

}
