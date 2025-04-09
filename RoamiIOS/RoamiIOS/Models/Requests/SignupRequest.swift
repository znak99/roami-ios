//
//  SignupRequest.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation

struct SignupRequest: Encodable {
    let name: String
    let email: String
    let password: String
}
