//
//  AsyncOperation.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation

class AsyncOperation: Operation {
    //: NSOperation Overrides
    override var isReady: Bool {
        super.isReady && state == .Ready
    }

    override var isExecuting: Bool {
        state == .Executing
    }

    override var isFinished: Bool {
        state == .Finished
    }

    override var isAsynchronous: Bool {
        true
    }

    override func start() {
        if isCancelled {
            state = .Finished
            return
        }

        main()
        state = .Executing
    }

    override func cancel() {
        state = .Finished
    }

    enum State: String {
        case Ready, Executing, Finished

        var keyPath: String {
            "is" + rawValue
        }
    }

    var state: State = State.Ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}
