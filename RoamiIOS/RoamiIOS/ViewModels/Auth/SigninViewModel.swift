//
//  SigninViewModel.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation
import SwiftUI

final class SigninViewModel: ObservableObject {
    @Published var email: String = "" {
        didSet {
            if email.contains(" ") {
                email = email.replacingOccurrences(of: " ", with: "")
            }
        }
    }
    @Published var password: String = "" {
        didSet {
            if password.contains(" ") {
                password = password.replacingOccurrences(of: " ", with: "")
            }
        }
    }
    
    @Published var errorMessage: String = ""
    
    @Published var isLoading: Bool = false
    @Published var isEmailValidated: Bool = false
    @Published var isPasswordValidated: Bool = false
    @Published var isPasswordVisible: Bool = false
    @Published var isShowSignedInAlert: Bool = false
    
    func validateEmail() {
        isEmailValidated = AuthService.shared.validateEmail(email: email)
    }
    
    func validatePassword() {
        isPasswordValidated = AuthService.shared.validatePassword(password: password)
    }
    
    func signin() {
        if email.isEmpty || password.isEmpty { return }
        
        if isLoading { return }
        
        errorMessage = ""
        isLoading = true
        
        AuthService.shared.signin(email: email, password: password) { result in
            switch result {
            case .success(let data):
                print("token: \(data.access_token)")
                self.isLoading = false
                
                AuthManager.shared.storeTokensToUserDefaults(access: data.access_token,
                                                             refresh: data.refresh_token,
                                                             accessExpiresAt: data.expires_at,
                                                             refreshExpriesAt: data.refresh_expires_at)
                
                self.isShowSignedInAlert = true
            case .failure(let error):
                switch error {
                case .invalidCredentials(let message), .serverError(message: let message):
                    print("SigninViewModel Server Error: \(message)")
                    self.errorMessage = message
                case .decodingError:
                    print("SigninViewModel Error: Decoding Error")
                case .noInternet:
                    print("SigninViewModel Error: No Internet")
                case .unknown(error: let err):
                    print("SigninViewModel Unknown Error: \(err.localizedDescription)")
                    self.errorMessage = err.localizedDescription
                }
                self.isLoading = false
                self.password = ""
            }
        }
    }
}
