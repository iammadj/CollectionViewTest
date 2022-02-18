//
//  MainEndpoint.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import Foundation
import Alamofire

enum MainEndpoint: Endpoint {
    case fetchData
    
    var url: String? {
        switch self {
        case .fetchData:
            return "b/620ca6bc1b38ee4b33bd9656"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchData:
            return .get
        }
    }
}
