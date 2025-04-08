//
//  TabBarButton.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct TabBarButton: View {
    
    let tab: AppTab
    
    @Binding var currentTab: AppTab
    
    var body: some View {
        Button(action: { currentTab = tab }) {
            VStack(spacing: 0) {
                Image(systemName: tab.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                Text(tab.title)
                    .font(.custom(AppFont.novaRound, size: 12))
            }
            .foregroundStyle(tab == currentTab ?
                             LinearGradient(colors: [Color.blue, Color.purple],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing)
                             : LinearGradient(colors: [Color.gray],
                                              startPoint: .topLeading,
                                              endPoint: .bottomTrailing))
            .frame(width: 48)
        }
    }
}

#Preview {
    TabBarButton(tab: .home, currentTab: .constant(.home))
}
