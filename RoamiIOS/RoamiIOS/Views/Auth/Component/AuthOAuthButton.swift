//
//  AuthOAuthButton.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import SwiftUI

struct AuthOAuthButton: View {
    
    let image: String
    let text: String
    
    @Binding var opacity: CGFloat
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 24, idealWidth: 28, maxWidth: 32,
                       minHeight: 24, idealHeight: 28, maxHeight: 32,
                       alignment: .center)
            Text(text)
                .font(.custom(AppFont.robotoRegular, size: 16))
            Spacer()
            Image(systemName: "chevron.right")
        }
        .foregroundStyle(Color.black)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .opacity(opacity)
    }
}

#Preview {
    AuthOAuthButton(image: "OAuth-Apple", text: "Sign In with Apple", opacity: .constant(1))
}
