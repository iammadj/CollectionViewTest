//
//  APIResponse.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import Foundation
import SwiftyJSON

protocol APIResponse {
    var response: HTTPURLResponse? { get }
    var data: Data? { get }
}

extension APIResponse {
    
    func body(for key: String?) -> Any? {
        guard let data = self.data else { return nil }
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                return try JSONSerialization.jsonObject(with: data, options: [])
            }
            
            guard let jsonData = json["data"] else { return json }
            
            if let jsonData = jsonData as? [String: Any] {
                if let key = key {
                    return jsonData[key]
                }
            }
            
            return jsonData
        } catch {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func bodyData(for key: String?) -> Data? {
        guard let json = self.body(for: key) else { return nil }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return data
        } catch {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func error() -> Error? {
        guard let body = self.body(for: nil) as? [String: Any] else { return nil }
        
        let isSuccess = (body["sucess"] as? Bool) ?? true
        
        if !isSuccess {
            let message = (body["message"] as? String) ?? ""
            return MessagedErrorr(message: message)
        }
        
        return nil
    }
    
}

//MARK: - Implementation

struct APIResponseImp: APIResponse {
    var response: HTTPURLResponse?
    var data: Data?
}
