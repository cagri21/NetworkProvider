//
//  NetworkOperation.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Alamofire
import Foundation

class NetworkOperation: AsyncOperation {

    // keep track of (a) urlRequest; and (b) closure to call when request is done
    private let urlRequest: URLRequestConvertible
    private var completion: ((Swift.Result<AFDataResponse<Data>, ExceptionHandler>) -> Void)

    weak var request: Alamofire.Request?

    var alamofireSessionManager: Session = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.urlCache?.removeAllCachedResponses()
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        configuration.httpShouldSetCookies = false
        var alamofireManager: Session = Alamofire.Session(
            configuration: configuration,
            interceptor: AuthInterceptor()
        )

        return alamofireManager
    }()

    init(request: URLRequestConvertible, completion: @escaping ((Swift.Result<AFDataResponse<Data>, ExceptionHandler>) -> Void)) {
        self.urlRequest = request
        self.completion = completion
        super.init()
    }

    override func main() {
        request = alamofireSessionManager.request(urlRequest).validate().responseData { [weak self] response in
            let result: Swift.Result<Bool, ExceptionHandler> = HTTPNetworkResponse.handleNetworkResponse(for: response.response)
            switch result {
            case .success:
                self?.completion(.success(response))
            case .failure(let error):
                self?.completion(.failure(error))
            }
        }
    }

    override func cancel() {
        request?.cancel()
        super.cancel()
    }

}
