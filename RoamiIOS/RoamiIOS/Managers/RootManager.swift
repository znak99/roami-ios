//
//  RootManager.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/10.
//

import Foundation
import Alamofire

final class RootManager: NetworkManager {
    
    static let shared: RootManager = RootManager()
    
    private override init() {}
    
    func launchApp(completion: @escaping (Result<RootResponse, NetworkError>) -> Void) {
        guard let baseUrl else {
            print("RootManager Error: URL is nil")
            return
        }
        
        let url: String = baseUrl + "/"
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: RootResponse.self) { response in
                switch response.result {
                case .success(let rootResponse):
                    completion(.success(rootResponse))
                case .failure(let error):
                    self.handleAFError(response, completion: completion)
                }
            }
    }
}
