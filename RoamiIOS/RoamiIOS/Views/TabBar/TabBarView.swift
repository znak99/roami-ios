//
//  TabBarView.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

enum AppTab {
    case home, search, upload, moment, profile
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .upload:
            return "Upload"
        case .moment:
            return "Moment"
        case .profile:
            return "Profile"
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .upload:
            return "square.and.pencil"
        case .moment:
            return "text.bubble"
        case .profile:
            return "person"
        }
    }
}

struct TabBarView: View {
    
    @State private var currentTab: AppTab = .home
    
    var body: some View {
        ZStack {
            Color.appBG.ignoresSafeArea()
            
            Group {
                switch currentTab {
                case .home:
                    HomeView()
                case .search:
                    SearchView()
                case .upload:
                    UploadView()
                case .moment:
                    MomentView()
                case .profile:
                    ProfileView()
                }
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    TabBarButton(tab: .home, currentTab: $currentTab)
                    Spacer()
                    TabBarButton(tab: .search, currentTab: $currentTab)
                    Spacer()
                    TabBarButton(tab: .upload, currentTab: $currentTab)
                    Spacer()
                    TabBarButton(tab: .moment, currentTab: $currentTab)
                    Spacer()
                    TabBarButton(tab: .profile, currentTab: $currentTab)
                    Spacer()
                }
                .padding(.top, 4)
                .background(Color.white)
            }
        }
    }
}

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
    TabBarView()
}
