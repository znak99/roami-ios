//
//  ProfileView.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var vm: ProfileViewModel = .init()
    
    var body: some View {
        ZStack {
            Color.appBG.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("PROFILE")
                        .font(.custom(AppFont.novaRound, size: 32))
                    Spacer()
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                            .foregroundStyle(Color.black)
                    }
                }
                Spacer()
                
                if AuthManager.shared.isAuthenticated {
                    Text("Authenticate")
                } else {
                    VStack(spacing: 8) {
                        Image(systemName: "person.fill.questionmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .foregroundStyle(Color.gray)
                        Text("No user info found!")
                            .font(.custom(AppFont.robotoSemiBold, size: 20))
                            .foregroundStyle(Color.gray)
                        Button(action: {
                            vm.isShowAuthView.toggle()
                        }) {
                            HStack {
                                Spacer()
                                Image(systemName: "person.and.background.dotted")
                                Text("Sign in to Roami")
                                    .font(.custom(AppFont.robotoMedium, size: 16))
                                Spacer()
                            }
                            .padding()
                            .foregroundStyle(LinearGradient(colors: [Color.blue, Color.purple],
                                                            startPoint: .leading,
                                                            endPoint: .trailing))
                        }
                        .frame(maxWidth: 240)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    Spacer()
                }
            }
            .padding([.top, .horizontal])
        }
        .fullScreenCover(isPresented: $vm.isShowAuthView, onDismiss: {}) {
            AuthView()
        }
    }
}

#Preview {
    ProfileView()
}
