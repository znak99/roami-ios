//
//  HomeView.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.appBG.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("HOME")
                        .font(.custom(AppFont.novaRound, size: 32))
                    Spacer()
                    NavigationLink(destination: EmptyView()) {
                        Image(systemName: "bell.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                            .foregroundStyle(Color.black)
                            .padding(.horizontal)
                    }
                    NavigationLink(destination: EmptyView()) {
                        Image(systemName: "slider.horizontal.3")
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
    HomeView()
}
