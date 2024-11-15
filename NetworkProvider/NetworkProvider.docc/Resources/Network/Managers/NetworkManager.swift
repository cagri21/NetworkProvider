//
//  NetworkManager.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Alamofire
import Foundation
import Reachability

class NetworkManager {

    static let sharedInstance: NetworkManager = NetworkManager()

    let operationsQueue: ROperationQueue = ROperationQueue()

    typealias JSONDataHandler = (Swift.Result<Data, ExceptionHandler>) -> Void

    func fetchData(apiRequest: URLRequestConvertible, completion: @escaping JSONDataHandler) {
        callApi(apiRequest: apiRequest) { result in
            switch result {
            case let .success(response):
                guard let data: Data = response.data else {
                    completion(.failure(ExceptionHandler.unwrappingError))
                    return
                }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: -
    // Only Applicable for get API that returns JSON:API in response

    typealias ApiResponseHandler = (Swift.Result<AFDataResponse<Data>, ExceptionHandler>) -> Void

    func callApi(apiRequest: URLRequestConvertible, completion: @escaping ApiResponseHandler) {
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
