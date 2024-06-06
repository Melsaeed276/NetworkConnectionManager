//
//  NetworkMonitor.swift
//  NetworkManager
//
//  Created by Mohamed Elsaeed on 22.05.2024.
//

import Foundation
import Network
import Combine

public class NetworkStatusController: ObservableObject {
    public static let shared = NetworkStatusController()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published public private(set) var isConnected = false
    @Published public private(set) var isExpensive = false
    
    private var statusChangeHandler: ((Bool, Bool) -> Void)?
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                let connected = path.status == .satisfied
                let expensive = path.isExpensive
                self?.isConnected = connected
                self?.isExpensive = expensive
                self?.statusChangeHandler?(connected, expensive)
            }
        }
        monitor.start(queue: queue)
    }
    
    public func setStatusChangeHandler(_ handler: @escaping (Bool, Bool) -> Void) {
        self.statusChangeHandler = handler
    }
    
    deinit {
        monitor.cancel()
    }
}
