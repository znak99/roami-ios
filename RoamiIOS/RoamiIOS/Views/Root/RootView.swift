//
//  RootView.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                TabBarView()
            }
        }
    }
}

#Preview {
    RootView()
}
