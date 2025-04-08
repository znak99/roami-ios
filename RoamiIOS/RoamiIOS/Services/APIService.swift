//
//  APIService.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation

class APIService {
    
    init () {}
    
    var url: String? {
        if let url = ProcessInfo.processInfo.environment["SERVER_URL_TEST"] {
            return url
        }
        
        print("APIService Error: URL is nil")
        return nil
    }
}
