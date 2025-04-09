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
        isEmailValidated = AuthValidator.isValidEmail(email)
    }
    
    func validatePassword() {
        isPasswordValidated = AuthValidator.isValidPassword(password)
    }
    
    func signin() {
        if email.isEmpty || password.isEmpty { return }
        
        if isLoading { return }
        
        errorMessage = ""
        isLoading = true
        
        AuthManager.shared.signin(email: email, password: password) { result in
            switch result {
            case .success(let data):
                self.isLoading = false
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
                
                self.password = ""
                self.isLoading = false
            }
        }
    }
}
