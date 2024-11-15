//
//  HTTPNetworkResponse.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation

struct HTTPNetworkResponse {
    // Properly checks and handles the status code of the response
    static func handleNetworkResponse(for response: HTTPURLResponse?) -> (Result<Bool, ExceptionHandler>) {

        guard let res = response else {
            return Result.failure(ExceptionHandler.invalidFormat)
        }

        switch res.statusCode {
        case 200...299:
            return .success(true)
        case 400:
            return .failure(ExceptionHandler.badRequest)
        case 401:
            return .failure(ExceptionHandler.unauthorized)
        case 403:
            return .failure(ExceptionHandler.notRegistered)
        case 404:
            return .failure(ExceptionHandler.notFound)
        case 500...599:
            return .failure(ExceptionHandler.serverSideError)
        default:
            return .failure(ExceptionHandler.undefined)
        }
    }
}
