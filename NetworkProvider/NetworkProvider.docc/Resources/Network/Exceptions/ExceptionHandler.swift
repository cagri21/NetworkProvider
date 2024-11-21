//
//  ExceptionHandler.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import UIKit

public enum ExceptionHandler: Error {

    case authError
    case badRequest
    case undefined
    case unauthorized
    case invalidFormat
    case notRegistered
    case logout
    case serverSideError
    case unwrappingError
    case noConnection
    case notFound

    public var localizedDescription: String {
        switch self {
        case .authError:
        return NSLocalizedString("Sorry, could not finish authentication. Invalid login credentials provided or you might have SSO login enabled. Please try again.", comment: "Auth error message")
        case .badRequest:
            return NSLocalizedString("Sorry, there has been a problem completing the request.", comment: "Bad request error message")
        case .undefined:
            return NSLocalizedString("Sorry, we're currently experiencing an internal server problem. Please try again.", comment: "Undefined error message")
        case .unauthorized:
            return NSLocalizedString("Sorry, unable to complete the request. Please try again later.", comment: "Unauthorized error message")
        case .notRegistered:
            return NSLocalizedString("There might be a technical issue.)", comment: "NotRegistered error message")
        case .logout:
            return NSLocalizedString("We could not log you out successfully, please try again.", comment: "Logout error message")
        case .serverSideError:
            return NSLocalizedString("Sorry, we're currently experiencing an internal server problem. Please try again later.", comment: "Server side error message")
        case .unwrappingError:
            return NSLocalizedString("Sorry, some data was missing from the response. Please try again or contact support.", comment: "Unwrapping error message")
        case .invalidFormat:
            return NSLocalizedString("Sorry, the operation couldn't be completed. Server response in invalid format. Please contact Support.", comment: "Invalid format error message")
        case .noConnection:
            return NSLocalizedString("The internet connection appears to be offline. Check your connection and try again.", comment: "No connection error message")
        case .notFound:
            return NSLocalizedString("Sorry, unable to complete the request. Please try again later.", comment: "Not found error message")
        }
    }

}
