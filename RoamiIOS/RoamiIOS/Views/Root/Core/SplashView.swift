//
//  SplashView.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct SplashView: View {
    
    @State private var blurRadius: CGFloat = 10
    @State private var isShowText: Bool = false
    @State private var isShowIndicator: Bool = false
    
    @Binding var isServerError: Bool
    
    var body: some View {
        ZStack {
            Color.appBG.ignoresSafeArea()
            
            VStack {
                Spacer()
                if isShowIndicator && !isServerError {
                    ProgressView()
                    Text("Syncing to the server...")
                        .font(.custom(AppFont.robotoLight, size: 16))
                        .foregroundStyle(Color.gray)
                }
                
                if isServerError {
                    Text("Something went wrong on the server\nPlease try again later")
                        .font(.custom(AppFont.robotoRegular, size: 16))
                        .foregroundStyle(Color.red)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.bottom, 64)
            
            VStack {
                Spacer()
                HStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48)
                    
                    if isShowText {
                        Text("ROAMI")
                            .font(.custom(AppFont.novaRound, size: 40))
                    }
                }
                .blur(radius: blurRadius)
                Spacer() 
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        withAnimation(.easeInOut(duration: 1)) {
            blurRadius -= 10
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.isShowText = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.isShowIndicator = true
        }
    }
}

#Preview {
    SplashView(isServerError: .constant(true))
}
