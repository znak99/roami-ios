//
//  RootView.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var vm: RootViewModel = .init()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if vm.isAppReady {
                    TabBarView()
                } else {
                    SplashView(isServerError: $vm.isNetworkError)
                }
            }
            .onAppear {
                vm.checkNetwork()
            }
        }
    }
}

#Preview {
    RootView()
}
