//
//  AuthManager.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation

final class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    private init() {}
    
    @Published var isAuthenticated: Bool = false
    
    @Published var accessToken: String? = nil
    @Published var refreshToken: String? = nil
    @Published var accessTokenExpiresAt: String? = nil
    @Published var refreshTokenExpiresAt: String? = nil
    
    func parseISODate(_ isoString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds
        ]
        return formatter.date(from: isoString)
    }
    
    func isTokenExpired(_ iso: Date) -> Bool {
        return iso < Date()
    }
    
    func patchTokensFromUserDefaults() {
        let userDefaults = UserDefaults.standard
        
        accessToken = userDefaults.string(forKey: "access_token")
        refreshToken = userDefaults.string(forKey: "refresh_token")
        accessTokenExpiresAt = userDefaults.string(forKey: "access_token_expires_at")
        refreshTokenExpiresAt = userDefaults.string(forKey: "refresh_token_expires_at")
        
        if let _ = accessToken, let _ = refreshToken,
           let _ = accessTokenExpiresAt, let refreshTokenExpriesAt = refreshTokenExpiresAt {
            if let refreshTokenExpireDate = parseISODate(refreshTokenExpriesAt) {
                self.isAuthenticated = !isTokenExpired(refreshTokenExpireDate)
            }
        }
    }
    
    func storeTokensToUserDefaults(access: String, refresh: String, accessExpiresAt: String, refreshExpriesAt: String) {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(access, forKey: "access_token")
        userDefaults.set(refresh, forKey: "refresh_token")
        userDefaults.set(accessExpiresAt, forKey: "access_token_expires_at")
        userDefaults.set(refreshExpriesAt, forKey: "refresh_token_expires_at")
        
        accessToken = access
        refreshToken = refresh
        accessTokenExpiresAt = accessExpiresAt
        refreshTokenExpiresAt = refreshExpriesAt
        
        isAuthenticated = true
    }
    
    func removeTokensFromUserDefaults() {
        let userDefaults = UserDefaults.standard
        
        userDefaults.removeObject(forKey: "access_token")
        userDefaults.removeObject(forKey: "refresh_token")
        userDefaults.removeObject(forKey: "access_token_expires_at")
        userDefaults.removeObject(forKey: "refresh_token_expires_at")
        
        accessToken = nil
        refreshToken = nil
        accessTokenExpiresAt = nil
        refreshTokenExpiresAt = nil
        
        isAuthenticated = false
    }
}
