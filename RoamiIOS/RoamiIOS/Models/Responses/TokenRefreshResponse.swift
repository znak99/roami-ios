//
//  TokenRefreshResponse.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/10.
//

import Foundation

struct TokenRefreshResponse: Decodable {
    let name: String
    let email: String
    let access_token: String
    let refresh_token: String
}
