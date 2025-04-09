//
//  AuthEmailButton.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct AuthEmailButton: View {
    
    let icon: String
    let text: String
    
    @Binding var opacity: CGFloat
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 20, idealWidth: 24, maxWidth: 28,
                       minHeight: 20, idealHeight: 24, maxHeight: 28,
                       alignment: .center)
            Text(text)
                .font(.custom(AppFont.robotoRegular, size: 16))
            Spacer()
            Image(systemName: "chevron.right")
        }
        .foregroundStyle(Color.black.opacity(opacity))
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    AuthEmailButton(icon: "envelope.fill", text: "Sign In with Email", opacity: .constant(1))
}
