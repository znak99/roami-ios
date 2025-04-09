//
//  UserInfo.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation

struct UserInfo: Codable {
    var name: String
    var email: String
    var accessToken: String
    var refreshToken: String
}
