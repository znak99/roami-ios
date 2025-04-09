//
//  SigninRequest.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation

struct SigninRequest: Encodable {
    let email: String
    let password: String
}
