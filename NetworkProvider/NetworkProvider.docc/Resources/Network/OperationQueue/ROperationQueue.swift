//
//  ROperationQueue.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation

class ROperationQueue {
    lazy var downloadQueue: OperationQueue = {
        var queue: OperationQueue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
        queue.qualityOfService = .userInitiated
        return queue
    }()
}
