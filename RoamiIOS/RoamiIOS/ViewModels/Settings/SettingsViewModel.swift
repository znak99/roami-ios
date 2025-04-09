//
//  SettingsViewModel.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/10.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    func signout() {
        AuthManager.shared.signout { response in
            switch response {
            case .success(let data):
                print("SettingsViewModel Response: \(data.message)")
            case .failure(let error):
                switch error {
                case .invalidCredentials(let message), .serverError(let message):
                    print("SettingsViewModel Server Error: \(message)")
                case .decodingError:
                    print("SettingsViewModel Error: Decoding Error")
                case .noInternet:
                    print("SettingsViewModel Error: No Internet")
                case .unknown(error: let err):
                    print("SettingsViewModel Unknown Error: \(err.localizedDescription)")
                }
            }
        }
    }
}
