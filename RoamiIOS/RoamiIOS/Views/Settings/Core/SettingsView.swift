//
//  SettingsView.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var vm: SettingsViewModel = SettingsViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.appBG.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("SETTINGS")
                        .font(.custom(AppFont.novaRound, size: 32))
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.gray)
                            .frame(width: 20)
                    }
                }
                
                VStack {
                    if AuthManager.shared.isAuthenticated {
                        Button(action: vm.signout) {
                            Text("Sign out")
                                .font(.custom(AppFont.robotoRegular, size: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color.red)
                        }
                        .padding()
                    }
                }
                .background(Color.white)
                
                Spacer()
            }
            .padding([.top, .horizontal])
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EmptyView()
            }
        }
        .background {
            EnableBackSwipeGesture()
        }
    }
}

#Preview {
    SettingsView()
}
