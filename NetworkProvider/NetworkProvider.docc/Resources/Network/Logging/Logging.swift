//
//  Logging.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation

public enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

public struct Logger {
    public static func log(
        _ level: LogLevel,
        _ message: @autoclosure () -> String,
        filename: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        #if DEBUG
        let timestamp = Logger.timestamp()
        let thread = Thread.isMainThread ? "MAIN" : "BACKGROUND"
        let file = (filename as NSString).lastPathComponent
        
        NSLog("[\(timestamp)] [\(level.rawValue)] [\(file):\(line) \(function)] [Thread: \(thread)] \(message())")
        #else
        // In RELEASE mode, consider directing logs to a file or logging service
        #endif
    }
    
    private static func timestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter.string(from: Date())
    }
}

// Convenience methods for specific log levels
public extension Logger {
    static func debug(_ message: @autoclosure () -> String, filename: String = #file, function: String = #function, line: Int = #line) {
        log(.debug, message(), filename: filename, function: function, line: line)
    }
    
    static func info(_ message: @autoclosure () -> String, filename: String = #file, function: String = #function, line: Int = #line) {
        log(.info, message(), filename: filename, function: function, line: line)
    }
    
    static func warning(_ message: @autoclosure () -> String, filename: String = #file, function: String = #function, line: Int = #line) {
        log(.warning, message(), filename: filename, function: function, line: line)
    }
    
    static func error(_ message: @autoclosure () -> String, filename: String = #file, function: String = #function, line: Int = #line) {
        log(.error, message(), filename: filename, function: function, line: line)
    }
}
