//
//  NetworkManager.swift
//  SuperWeather
//
//  Created by vrez on 20.02.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation
import Reachability

class NetworkManager : NSObject {
    var reachability: Reachability!
    
    static let sharedInstance: NetworkManager = {
        return NetworkManager()
    } ()
    override init() {
        super.init()
        
        reachability = try! Reachability()
        
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch
        {
            print("Unnable to start notifier")
            
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // do something
    }
    
    static func stopNotifier() -> Void {
        do {
            try (NetworkManager.sharedInstance.reachability).startNotifier()
        }
        catch {
            print("Error start notifier")
        }
    }
    
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection != .unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    static func isUnreacheble(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .wifi {            completed(NetworkManager.sharedInstance)
            
        }
    }
    
}
