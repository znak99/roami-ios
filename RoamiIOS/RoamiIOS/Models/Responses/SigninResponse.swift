//
//  SigninResponse.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation

struct SigninResponse: Decodable {
    let access_token: String
    let expires_at: String
    let refresh_token: String
    let refresh_expires_at: String
    let token_type: String
}
