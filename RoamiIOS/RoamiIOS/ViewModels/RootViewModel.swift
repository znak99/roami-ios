//
//  RootViewModel.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation

final class RootViewModel: ObservableObject {
    
    @Published var isAppReady: Bool = false
    @Published var isServerError: Bool = false
    
    func checkNetwork() {
        RootService.shared.checkNetwork() { result in
            switch result {
            case .success(let response):
                print("RootViewModel Response: \(response.status)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.isAppReady = true
                }
            case .failure(let error):
                print("RootViewModel Error: \(error)")
                self.isServerError = false
            }
        }
    }
}
