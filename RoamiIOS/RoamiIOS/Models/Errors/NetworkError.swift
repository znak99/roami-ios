//
//  NetworkError.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation

enum NetworkError: Error {
    case invalidCredentials(message: String)
    case serverError(message: String)
    case decodingError
    case noInternet
    case unknown(error: Error)
}
