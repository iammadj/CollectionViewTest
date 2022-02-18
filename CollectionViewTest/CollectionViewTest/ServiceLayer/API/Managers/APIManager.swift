//
//  APIManager.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import Foundation
import Alamofire

typealias AFResult<T> = Result<T, Error>

protocol APIManager {
    func request(with endpoint: Endpoint, result: @escaping (AFResult<APIResponse>) -> Void)
}

//MARK: - Implementation

struct APIManagerImp: APIManager {
    
    func request(with endpoint: Endpoint, result: @escaping (AFResult<APIResponse>) -> Void) {
        guard let path = endpoint.url,
              let url = URL(string: endpoint.baseURL + path) else {
            return
        }
        
        AF.request(url, method: endpoint.method, parameters: endpoint.params, encoding: endpoint.encoding, headers: endpoint.headers, interceptor: nil, requestModifier: nil)
            .validate()
            .responseJSON { response in
                if let error = response.error {
                    result(.failure(error))
                }
                
                let resp = APIResponseImp(response: response.response, data: response.data)
                
                if let error = resp.error() {
                    result(.failure(error))
                    return
                }
                
                result(.success(resp))
            }
    }
    
}
