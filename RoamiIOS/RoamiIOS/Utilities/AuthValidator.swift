//
//  AuthValidator.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/10.
//

import Foundation

struct AuthValidator {
    static func isValidEmail(_ email: String) -> Bool {
        let regex = "^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }

    static func isValidPassword(_ password: String) -> Bool {
        let regex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?\":{}|<>\\-=]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
}
