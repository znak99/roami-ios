//
//  AuthService.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation
import Alamofire

final class AuthService: APIService {
    
    static let shared = AuthService()
    
    private override init() {}
    
    func validateEmail(email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: email)
    }
    
    func validatePassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?\":{}|<>\\-=]).{8,}$"
            
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return passwordTest.evaluate(with: password)
    }
    
    func signin(email: String, password: String, completion: @escaping (Result<SigninResponse, NetworkError>) -> Void) {
        guard let url else {
            print("AuthService Error: URL is nil")
            return
        }
        
        let parameters = SigninRequest(email: email, password: password)
        
        AF.request(url + "/auth/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: SigninResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure:
                    self.handleAFError(response, completion: completion)
                }
            }
    }
}
