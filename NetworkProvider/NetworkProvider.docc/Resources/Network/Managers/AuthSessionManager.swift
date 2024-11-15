//
//  RMAuthSessionManager.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Alamofire
import Foundation
import SwiftKeychainWrapper

// MARK: - Auth interceptor
final class AuthInterceptor: RequestInterceptor {

    // MARK: - Properties
    // Adds platform header to all alamofire request calls
    // Adds Datadog tracing to all request calls
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {

        var request: URLRequest = urlRequest

//        guard let accessToken: String = KeychainWrapper.standard.string(forKey: Authentication.accessToken) else {
//            completion(.failure(ExceptionHandler.noToken))
//            return
//        }
//
//        let timestamp: String = String(Int(Date().timeIntervalSince1970))
//
//        request.setValue(timestamp, forHTTPHeaderField: "TIMESTAMP")
//        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
//
//        request.setValue("application/vnd.api+json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/vnd.api+json", forHTTPHeaderField: "Accept")
//        request.setValue("uuid", forHTTPHeaderField: "RISKMETHODS_API_V2_ID")
//        request.setValue("iOS", forHTTPHeaderField: "RISKMETHODS_PLATFORM")

        completion(.success(request))
    }
}
