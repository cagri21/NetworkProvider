//
//  NetworkManager.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Alamofire
import Foundation
import Reachability

final class NetworkManager {

    static let sharedInstance: NetworkManager = NetworkManager()

    let operationsQueue: RequestOperationQueue = RequestOperationQueue()

    typealias JSONDataHandler = (Swift.Result<Data, ExceptionHandler>) -> Void

    func fetchData(apiRequest: URLRequestConvertible, completion: @escaping JSONDataHandler) {
        callApi(apiRequest: apiRequest) { result in
            switch result {
            case let .success(response):
                guard let data: Data = response.data else {
                    Logger.error("Parsing error")
                    completion(.failure(ExceptionHandler.unwrappingError))
                    return
                }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - callApi
    typealias ApiResponseHandler = (Swift.Result<AFDataResponse<Data>, ExceptionHandler>) -> Void

    func callApi(apiRequest: URLRequestConvertible, completion: @escaping ApiResponseHandler) {
        if let reachability: Reachability = try? Reachability() {
            if reachability.connection == Reachability.Connection.unavailable {
                operationsQueue.downloadQueue.cancelAllOperations()
                completion(.failure(ExceptionHandler.noConnection))
            }
        }

        let callApiOperation: NetworkOperation = NetworkOperation(request: apiRequest) { connection in
            switch connection {
            case .success(let connection):
                completion(.success(connection))
            case .failure(let error):
                completion(.failure(error))
            }
       }
        operationsQueue.downloadQueue.addOperation(callApiOperation)

    }
}
