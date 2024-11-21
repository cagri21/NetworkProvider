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
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {

        var request: URLRequest = urlRequest

        request.setValue("application/vnd.api+json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/vnd.api+json", forHTTPHeaderField: "Accept")

        completion(.success(request))
    }
}
