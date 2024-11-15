//
//  Logging.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation

public func DLog(_ message: @autoclosure () -> String, filename: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
        NSLog("[\((filename as NSString).lastPathComponent):\(line) (\(function))] \(message())")
    #endif
}
