//
//  Endpoint.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import Foundation
import Alamofire

protocol Endpoint {
    var method: HTTPMethod { get }
    var body: Data? { get }
    var params: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
    var encoding: Alamofire.ParameterEncoding { get }
    var baseURL: String { get }
    var url: String? { get }
}

extension Endpoint {
    var body: Data? { nil }
    var params: [String: Any]? { nil }
    var headers: HTTPHeaders? { nil }
    var encoding: Alamofire.ParameterEncoding { URLEncoding.default }
    var baseURL: String { "https://api.jsonbin.io/" }
}
