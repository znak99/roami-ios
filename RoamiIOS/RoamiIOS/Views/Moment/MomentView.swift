//
//  MomentView.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct MomentView: View {
    var body: some View {
        ZStack {
            Color.appBG.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("MOMENT")
                        .font(.custom(AppFont.novaRound, size: 32))
                    Spacer()
                    NavigationLink(destination: SettingView()) {
                        Image(systemName: "pencil")
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
    MomentView()
}
