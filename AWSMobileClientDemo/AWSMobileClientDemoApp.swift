//
//  AWSMobileClientDemoApp.swift
//  AWSMobileClientDemo
//
//  Created by Ameter, Chris on 6/11/22.
//

import SwiftUI
import AWSCore

@main
struct AWSMobileClientDemoApp: App {
    
    @ObservedObject var mobileClientManager = MobileClientManager()
    
    init() {
        AWSDDLog.sharedInstance.logLevel = .verbose
    }
    
    var body: some Scene {
        WindowGroup {
            SessionView()
                .environmentObject(mobileClientManager)
        }
    }
}
