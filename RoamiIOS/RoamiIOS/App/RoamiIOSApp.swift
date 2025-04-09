//
//  RoamiIOSApp.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

@main
struct RoamiIOSApp: App {
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(AuthManager.shared)
                .onAppear {
                    AuthManager.shared.patchTokensFromUserDefaults()
                }
        }
    }
}
