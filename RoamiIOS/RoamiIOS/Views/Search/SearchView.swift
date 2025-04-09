//
//  SearchView.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            Color.appBG.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("SEARCH")
                        .font(.custom(AppFont.novaRound, size: 32))
                    Spacer()
                }
                Spacer()
            }
            .padding([.top, .horizontal])
        }
    }
}

#Preview {
    SearchView()
}
