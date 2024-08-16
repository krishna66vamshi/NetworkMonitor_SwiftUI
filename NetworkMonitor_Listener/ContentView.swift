//
//  ContentView.swift
//  NetworkMonitor_Listener
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var networkMonitor = NetworkMonitor()
    
    var body: some View {
        VStack {
            if networkMonitor.isConnected {
                Text("Connected via \(networkMonitor.connectionType)")
                    .font(.title)
                    .foregroundColor(.green)
            } else {
                Text("No Internet Connection")
                    .font(.title)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .onAppear {
            // Additional setup if needed
            networkMonitor.startMonitoring()
        }
        .onDisappear {
            networkMonitor.stopMonitoring()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
