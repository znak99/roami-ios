//
//  AuthView.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct AuthView: View {
    
    @State private var gradientHeight: CGFloat = 0
    @State private var opacity: CGFloat = 0
    
    @State private var hasAnimated: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBG.ignoresSafeArea()
                
                VStack {
                    ZStack {
                        LinearGradient(colors: [.blue.opacity(opacity), .purple.opacity(opacity)],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                        LinearGradient(colors: [.white.opacity(0), .white.opacity(1)],
                                       startPoint: .top,
                                       endPoint: .bottom)
                    }
                    .ignoresSafeArea()
                    .frame(height: gradientHeight)
                    Spacer()
                }
                
                VStack(spacing: 32) {
                    HStack {
                        Image(systemName: "person.and.background.dotted")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32)
                        Text("Authentications")
                            .font(.custom(AppFont.robotoBold, size: 24))
                        Spacer()
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                        }
                    }
                    .foregroundStyle(Color.white)
                    .padding(.top, 56)
                    
                    Text("Don't let your memories fade away.\nJoin us to create your personal travel log and connect with others who love exploring as much as you do.")
                        .font(.custom(AppFont.robotoRegular, size: 16))
                        .foregroundStyle(Color.white)
                        .padding()
                    
                    VStack(spacing: 40) {
                        VStack {
                            NavigationLink(destination: SigninView()) {
                                AuthEmailButton(icon: "at", text: "Sign In with Email", opacity: $opacity)
                            }
                            .disabled(AuthManager.shared.isAuthenticated)
                            NavigationLink(destination: SignupView()) {
                                AuthEmailButton(icon: "person.fill.badge.plus", text: "Sign Up with Email", opacity: $opacity)
                            }
                            .disabled(AuthManager.shared.isAuthenticated)
                        }
                        
                        VStack {
                            Button(action: {}) {
                                AuthOAuthButton(image: "OAuth-Apple", text: "Sign In with Apple", opacity: $opacity)
                            }
                            .disabled(AuthManager.shared.isAuthenticated)
                            Button(action: {}) {
                                AuthOAuthButton(image: "OAuth-Google", text: "Sign In with Google", opacity: $opacity)
                            }
                            .disabled(AuthManager.shared.isAuthenticated)
                            Button(action: {}) {
                                AuthOAuthButton(image: "OAuth-Facebook", text: "Sign In with Facebook", opacity: $opacity)
                            }
                            .disabled(AuthManager.shared.isAuthenticated)
                        }
                    }
                    
                    Spacer()
                }
                .padding([.top, .horizontal])
            }
            .onAppear {
                if AuthManager.shared.isAuthenticated {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        dismiss()
                    }
                }
                
                if !hasAnimated {
                    hasAnimated = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeOut(duration: 3)) {
                            opacity += 1
                            gradientHeight += 600
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AuthView()
}
