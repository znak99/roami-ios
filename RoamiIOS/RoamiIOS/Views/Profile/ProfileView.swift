//
//  ProfileView.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var vm: ProfileViewModel = .init()
    
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        ZStack {
            Color.appBG.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("PROFILE")
                        .font(.custom(AppFont.novaRound, size: 32))
                    Spacer()
                    NavigationLink(destination: SettingView()) {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                            .foregroundStyle(Color.black)
                    }
                }
                Spacer()
            }
            .padding([.top, .horizontal])
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthManager())
}
