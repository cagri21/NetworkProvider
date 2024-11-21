//
//  ReachabilityManager.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation
import Network
import Reachability
import SystemConfiguration

// swiftlint:disable force_cast
final public class ReachabilityManager: NSObject {
    public static  let shared: ReachabilityManager = ReachabilityManager()  // 2. Shared instance
// swiftlint:disable implicit_return
    var isNetworkAvailable: Bool {
        return reachabilityStatus != .unavailable
    }

    var reachabilityStatus: Reachability.Connection = .unavailable

    // swiftlint:disable explicit_type_interface
    let reachability = try? Reachability()

    var listeners: [NetworkStatusListener] = [NetworkStatusListener]()

    @objc
    func reachabilityChanged(notification: Notification) {

        let reachability = notification.object as! Reachability

        switch reachability.connection {
        case .unavailable:
                debugPrint("Network became unreachable")
        case .wifi:
                debugPrint("Network reachable through WiFi")
        case .cellular:
                debugPrint("Network reachable through Cellular Data")
        }

        for listener in listeners {
            listener.networkStatusDidChange(status: reachability.connection)
        }
    }

    // swiftlint:enable implicit_return
    // swiftlint:enable explicit_type_interface

    public func startMonitoring() {

        guard let reachability: Reachability = reachability else {
            debugPrint("Could reach Reachability instance")
            return
        }

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }

    /// Stops monitoring the network availability status
    public func stopMonitoring() {
        guard let reachability: Reachability = reachability else {
            debugPrint("Could reach Reachability instance")
            return
        }
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }

    public func addListener(listener: NetworkStatusListener) {
        listeners.append(listener)
    }

    /// Removes a listener from listeners array
    ///
    /// - parameter delegate: the listener which is to be removed
    public func removeListener(listener: NetworkStatusListener) {
        listeners = listeners.filter { $0 !== listener }
    }
}

public protocol NetworkStatusListener: AnyObject {
    func networkStatusDidChange(status: Reachability.Connection)
}
// swiftlint:enable force_cast
