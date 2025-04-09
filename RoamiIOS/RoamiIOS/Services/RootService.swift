//
//  RootService.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation
import Alamofire

final class RootService: APIService {
    
    static let shared = RootService()
    
    private override init() {}
    
    func checkNetwork(completion: @escaping (Result<RootResponse, NetworkError>) -> Void) {
        guard let url else {
            print("RootService Error: URL is nil")
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: RootResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure:
                    self.handleAFError(response, completion: completion)
                }
            }
    }
}
