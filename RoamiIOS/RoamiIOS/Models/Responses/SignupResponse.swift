//
//  SignupResponse.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation

struct SignupResponse: Decodable {
    let name: String
    let email: String
    let access_token: String
    let refresh_token: String
}
