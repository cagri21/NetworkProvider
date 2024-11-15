//
//  Authentication.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Alamofire
import Foundation
import OAuthSwift
import SwiftKeychainWrapper

public class Auth {
    public static func setupClientIdAndSecretKey() -> String {
        let environment: BackendType = BackendType(rawValue: UserDefaults.activeBackend) ?? .live

        return environment.rawValue
    }
}
