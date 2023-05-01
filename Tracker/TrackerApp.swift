//
//  TrackerApp.swift
//  Tracker
//
//  Created by Luka Lešić on 20.04.2023..
//

import SwiftUI
import Firebase

@main
struct TrackerApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
