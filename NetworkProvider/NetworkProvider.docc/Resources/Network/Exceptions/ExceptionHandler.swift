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
    case notFound
    case logout
    case actionPlanExists
    case invalidEmail
    case serverSideError
    case unwrappingError
    case retryError
    case unProcessableEntity
    case noConnection
    case noToken

    public var localizedDescription: String {
        switch self {
        case .authError:
        return NSLocalizedString("Sorry, could not finish authentication. Invalid login credentials provided or you might have SSO login enabled. Please try again.", comment: "RMException.authError error message")
        case .badRequest:
            return NSLocalizedString("Sorry, there has been a problem completing the request (Error code: BDR400). Please contact Support.", comment: "RMException.badRequest error message")
        case .undefined:
            return NSLocalizedString("Sorry, we're currently experiencing an internal server problem. Please try again or contact Support.", comment: "RMException.undefined error message")
        case .unauthorized:
            return NSLocalizedString("Sorry, unable to complete the request. Please try again later. (Error code: UATH401)", comment: "RMException.unauthorized error message")
        case .notRegistered:
            #if os(iOS)
                return NSLocalizedString("There might be a technical issue. Please contact Support. (Error code: NR403)", comment: "RMException.notRegistered error message")
            #endif

            #if os(tvOS)
                return NSLocalizedString("You are not subscribed to this service, please contact Support. (Error code: NR403)", comment: "RMException.notRegistered error message")
            #endif
        case .logout:
            return NSLocalizedString("We could not log you out successfully, please try again.", comment: "RMException.logout error message")
        case .actionPlanExists:
            return NSLocalizedString("There is an existing inactive action plan.", comment: "RMException.actionPlanExists error message")
        case .invalidEmail:
            return NSLocalizedString("The email address is not valid.", comment: "RMException.invalidEmail error message")
        case .serverSideError:
            return NSLocalizedString("Sorry, we're currently experiencing an internal server problem. Please try again later. (Error code: ISVR500)", comment: "RMException.serverSideError error message")
        case .unwrappingError:
            return NSLocalizedString("Sorry, some data was missing from the response. Please try again or contact support.", comment: "RMException.unwrappingError error message")
        case .notFound:
            return NSLocalizedString("Sorry, unable to complete the request. Please try again later. (Error code: NF404)", comment: "RMException.notFound error message")
        case .retryError:
            return NSLocalizedString("Sorry, there was an authentication error. Tried maximum retries for the request (Error code: RTRYXX).\nPlease contact your administrator.", comment: "RMException.retryError error message")
        case .unProcessableEntity:
            return NSLocalizedString("Sorry, there was an authentication error. Tried maximum retries for the request (Error code: UPE422).\nPlease contact your administrator.", comment: "RMException.unProcessableEntity error message")
        case .invalidFormat:
            return NSLocalizedString("Sorry, the operation couldn't be completed. Server response in invalid format. Please contact Support.", comment: "RMException.invalidFormat error message")
        case .noConnection:
            return NSLocalizedString("The internet connection appears to be offline. Check your connection and try again.", comment: "RMException.noConnection error message")
        case .noToken:
            return NSLocalizedString("Please enter your log-in credentials to access Sphera SCRM services. Please contact service desk customercare@sphera.com if you forgot your password.", comment: "RMException.invalidToken error message")
        }
    }

}
