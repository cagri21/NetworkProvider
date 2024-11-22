//
//  BackendEnvironment.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//
import Foundation

open class BackendEnvironment {

    public static func switchEnvironment(_ givenHostName: BackendType) -> String {
        UserDefaults.activeUrl = givenHostName.hostName
        UserDefaults.activeBackend = givenHostName.rawValue

        return ("You are now connected to the \(givenHostName.rawValue) system.")
    }

    public static func switchTo(_ givenHostName: String) -> (Bool, String) {
        let unswitchedValue: (Bool, String) = (false, "")
        let trimmedGivenHostname: String = givenHostName.trimmingCharacters(in: .whitespacesAndNewlines)

        let backendName: String = trimmedGivenHostname
        if let selectedBackend: BackendType = BackendType(rawValue: backendName) {
            _ = self.switchEnvironment(selectedBackend)
        }

        return (true, "You are now connected to the \(backendName) system.")

    }
}

public enum BackendType: String {
    case live
    case staging

    public static let allTypes: [BackendType] = [
        .live,
        .staging
    ]

    public static let allHostNames: [String] = allTypes.map { $0.hostName }

    public var hostName: String {

        if rawValue == BackendType.live.rawValue {
            return "private-d3ae2-n11case.apiary-mock.com"
        } else {
            return "private-d3ae2-n11case.apiary-mock.com"
        }
    }
}
