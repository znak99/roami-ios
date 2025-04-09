//
//  APIService.swift
//  RoamiIOS
//
//  Created by seungwoo on 2025/04/09.
//

import Foundation
import Alamofire

class APIService {
    
    init () {}
    
    var url: String? {
        if let url = ProcessInfo.processInfo.environment["SERVER_URL_TEST"] {
            return url
        }
        
        print("APIService Error: URL is nil")
        return nil
    }
    
    func handleAFError<T: Decodable>(_ response: DataResponse<T, AFError>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let afError = response.error

        if let urlError = afError?.underlyingError as? URLError,
           urlError.code == .notConnectedToInternet {
            completion(.failure(.noInternet))
            return
        }

        if let data = response.data,
           let serverError = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
            let statusCode = response.response?.statusCode ?? 0
            if statusCode == 401 {
                completion(.failure(.invalidCredentials(message: serverError.detail)))
            } else {
                completion(.failure(.serverError(message: serverError.detail)))
            }
            return
        }

        if afError?.isResponseSerializationError == true {
            completion(.failure(.decodingError))
        } else if let afError = afError {
            completion(.failure(.unknown(error: afError)))
        } else {
            completion(.failure(.unknown(error: NSError(domain: "", code: -1, userInfo: nil))))
        }
    }

}
