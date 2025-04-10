//
//  AuthManager.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation
import KeychainSwift
import Alamofire

final class AuthManager: NetworkManager {
    
    static let shared: AuthManager = AuthManager()
    
    private override init() {}
    
    private let keychain = KeychainSwift()
    
    var isAuthenticated: Bool = false
    var userInfo: UserInfo? = nil
    
    func signin(email: String, password: String, completion: @escaping (Result<SigninResponse, NetworkError>) -> Void) {
        guard let baseUrl else {
            print("AuthManager Error: URL is nil")
            return
        }
        
        let url: String = baseUrl + "/auth/login"
        let parameters: SigninRequest = SigninRequest(email: email, password: password)
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: SigninResponse.self) { response in
                switch response.result {
                case .success(let signinResponse):
                    self.userInfo = UserInfo(name: signinResponse.name,
                                             email: signinResponse.email,
                                             accessToken: signinResponse.access_token,
                                             refreshToken: signinResponse.refresh_token)
                    if let userInfo = self.userInfo {
                        self.storeUserInfo(userInfo)
                        self.isAuthenticated = true
                        completion(.success(signinResponse))
                    } else {
                        self.handleAFError(response, completion: completion)
                    }
                case .failure:
                    self.handleAFError(response, completion: completion)
                }
            }
    }
    
    func signup(name: String, email: String, password: String, completion: @escaping (Result<SignupResponse, NetworkError>) -> Void) {
        guard let baseUrl else {
            print("AuthManager Error: URL is nil")
            return
        }
        
        let url: String = baseUrl + "/auth/signup"
        let parameters: SignupRequest = SignupRequest(name: name, email: email, password: password)
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: SignupResponse.self) { response in
                switch response.result {
                case .success(let signupResponse):
                    self.userInfo = UserInfo(name: signupResponse.name,
                                             email: signupResponse.email,
                                             accessToken: signupResponse.access_token,
                                             refreshToken: signupResponse.refresh_token)
                    if let userInfo = self.userInfo {
                        self.storeUserInfo(userInfo)
                        self.isAuthenticated = true
                        completion(.success(signupResponse))
                    } else {
                        self.handleAFError(response, completion: completion)
                    }
                case .failure:
                    self.handleAFError(response, completion: completion)
                }
            }
    }
    
    func signout(completion: @escaping (Result<SignoutResponse, NetworkError>) -> Void) {
        guard let baseUrl else {
            print("AuthManager Error: URL is nil")
            return
        }
        
        guard let userInfo else {
            print("AuthManager Error: UserInfo is nil")
            return
        }
        
        let url: String = baseUrl + "/auth/logout"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(userInfo.refreshToken)",
            "Content-Type": "application/json",
        ]
        
        AF.request(url, method: .post, headers: headers)
            .validate()
            .responseDecodable(of: SignoutResponse.self) { response in
                switch response.result {
                case .success(let signoutResponse):
                    self.removeUserInfo()
                    self.userInfo = nil
                    self.isAuthenticated = false
                    completion(.success(signoutResponse))
                case .failure:
                    self.handleAFError(response, completion: completion)
                }
            }
    }
    
    func refreshToken(completion: @escaping (Result<TokenRefreshResponse, NetworkError>) -> Void) {
        guard let baseUrl else {
            print("AuthManager Error: URL is nil")
            return
        }
        
        guard let userInfo else {
            print("AuthManager Error: UserInfo is nil")
            return
        }
        
        let url: String = baseUrl + "/auth/refresh"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(userInfo.refreshToken)",
            "Content-Type": "application/json",
        ]
        let parameters: TokenRefreshRequest = TokenRefreshRequest(refresh_token: userInfo.refreshToken)
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: TokenRefreshResponse.self) { response in
                switch response.result {
                case .success(let tokenRefreshResponse):
                    self.userInfo = UserInfo(name: tokenRefreshResponse.name,
                                             email: tokenRefreshResponse.email,
                                             accessToken: tokenRefreshResponse.access_token,
                                             refreshToken: tokenRefreshResponse.refresh_token)
                    if let userInfo = self.userInfo {
                        self.storeUserInfo(userInfo)
                        self.isAuthenticated = true
                        completion(.success(tokenRefreshResponse))
                    } else {
                        self.handleAFError(response, completion: completion)
                    }
                case .failure:
                    self.handleAFError(response, completion: completion)
                }
            }
    }
    
    private func storeUserInfo(_ userInfo: UserInfo) {
        keychain.synchronizable = true
        
        do {
            let data = try JSONEncoder().encode(userInfo)
            keychain.set(data, forKey: "USER_INFO")
        } catch {
            print("AuthManager Error: UserInfo encoding error")
        }
    }
    
    private func loadUserInfo(_ userInfo: UserInfo) {
        keychain.synchronizable = true
        
        do {
            if let data = keychain.getData("USER_INFO") {
                self.userInfo = try JSONDecoder().decode(UserInfo.self, from: data)
            }
        } catch {
            print("AuthManager Error: UserInfo decoding error")
        }
    }
    
    private func removeUserInfo() {
        keychain.synchronizable = true
        keychain.delete("USER_INFO")
    }
}
