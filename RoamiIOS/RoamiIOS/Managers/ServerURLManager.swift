//
//  ServerURLManager.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation
import KeychainSwift

final class ServerURLManager {
    
    static let shared = ServerURLManager()
    
    private init() {}
    
    private let keychain = KeychainSwift()
    private let key = "SERVER_URL"
    
    func initializeServerURL() {
        if UserDefaults.standard.bool(forKey: "IS_INITIALIZED") {
            return
        }
        
        if let url = Bundle.main.object(forInfoDictionaryKey: key) as? String {
            saveServerURL(url)
            UserDefaults.standard.set(true, forKey: "IS_INITIALIZED")
        } else {
            print("ServerURLManager: SERVER_URL not found in info.plist")
        }
    }
    
    func getServerURL() -> String? {
        return keychain.get(key)
    }
    
    func saveServerURL(_ url: String) {
        keychain.set(url, forKey: key)
    }
}
