//
//  RootViewModel.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation

final class RootViewModel: ObservableObject {
    
    @Published var isAppReady: Bool = false
    @Published var isNetworkError: Bool = false
    
    func checkNetwork() {
        RootService.shared.checkNetwork() { result in
            switch result {
            case .success(let data):
                print("RootViewModel Response: \(data.status)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.isAppReady = true
                }
            case .failure(let error):
                switch error {
                case .invalidCredentials(let message), .serverError(let message):
                    print("RootViewModel Server Error: \(message)")
                case .decodingError:
                    print("RootViewModel Error: Decoding Error")
                case .noInternet:
                    print("RootViewModel Error: No Internet")
                case .unknown(error: let err):
                    print("RootViewModel Unknown Error: \(err.localizedDescription)")
                }
                
                self.isNetworkError = false
            }
        }
    }
}
