//
//  SignupViewModel.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/10.
//

import Foundation

final class SignupViewModel: ObservableObject {
    @Published var name: String = "" {
        didSet {
            if name.contains(" ") {
                name = name.replacingOccurrences(of: " ", with: "")
            }
        }
    }
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
    @Published var confirmPassword: String = "" {
        didSet {
            if confirmPassword.contains(" ") {
                confirmPassword = confirmPassword.replacingOccurrences(of: " ", with: "")
            }
        }
    }
    
    @Published var errorMessage: String = ""
    
    @Published var isLoading: Bool = false
    @Published var isNameValidated: Bool = false
    @Published var isEmailValidated: Bool = false
    @Published var isPasswordValidated: Bool = false
    @Published var isConfirmPasswordValidated: Bool = false
    @Published var isPasswordVisible: Bool = false
    @Published var isShowSignedUpAlert: Bool = false
    
    func validateName() {
        isNameValidated = AuthValidator.isValidName(name)
    }
    
    func validateEmail() {
        isEmailValidated = AuthValidator.isValidEmail(email)
    }
    
    func validatePassword() {
        isPasswordValidated = AuthValidator.isValidPassword(password)
    }
    
    func validateConfirmPassword() {
        isConfirmPasswordValidated = password == confirmPassword
    }
    
    func signup() {
        if !isNameValidated || !isEmailValidated || !isPasswordValidated || !isConfirmPasswordValidated {
            errorMessage = "All fields are required!"
            return
        }
        
        if isLoading {
            errorMessage = "Please wait, now signing up..."
            return
        }
        
        errorMessage = ""
        isLoading = true
        
        AuthManager.shared.signup(name: name, email: email, password: password) { result in
            switch result {
                
            case .success:
                self.isLoading = false
                self.isShowSignedUpAlert = true
            case .failure(let error):
                switch error {
                case .invalidCredentials(let message), .serverError(message: let message):
                    print("SignupViewModel Server Error: \(message)")
                    self.errorMessage = message
                case .decodingError:
                    print("SignupViewModel Error: Decoding Error")
                case .noInternet:
                    print("SignupViewModel Error: No Internet")
                case .unknown(error: let err):
                    print("SignupViewModel Unknown Error: \(err.localizedDescription)")
                    self.errorMessage = err.localizedDescription
                }
                
                self.password = ""
                self.confirmPassword = ""
                self.isLoading = false
            }
            
            if self.errorMessage == "Please wait, now signing in..." {
                self.errorMessage = ""
            }
        }
    }
}
