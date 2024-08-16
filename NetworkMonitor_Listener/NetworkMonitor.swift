//
//  NetworkMonitor.swift
//  NetworkMonitor_Listener
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import SwiftUI
import Network

class NetworkMonitor: ObservableObject {
    private var monitor: NWPathMonitor
    private var queue: DispatchQueue

    @Published var isConnected: Bool = true
    @Published var connectionType: String = "Unknown"

    init() {
        monitor = NWPathMonitor()
        queue = DispatchQueue(label: "NetworkMonitor")
        startMonitoring()
    }

    deinit {
        stopMonitoring()
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self!.isConnected = path.status == .satisfied
                self!.connectionType = self!.getConnectionType(from: path)
            }
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }

    private func getConnectionType(from path: NWPath) -> String {
        if path.usesInterfaceType(.wifi) {
            return "WiFi"
        } else if path.usesInterfaceType(.cellular) {
            return "Cellular"
        } else if path.usesInterfaceType(.wiredEthernet) {
            return "Wired Ethernet"
        } else if path.usesInterfaceType(.loopback) {
            return "Loopback"
        } else {
            return "Unknown"
        }
    }
}
