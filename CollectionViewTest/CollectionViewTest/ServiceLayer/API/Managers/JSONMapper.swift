//
//  JSONMapper.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import Foundation
import SwiftyJSON

protocol JSONMapper {
    func mapToObject<T: Decodable>(from data: Data, type: T.Type) throws -> T
}

extension JSONMapper {
    
    func mapToResult<T: Decodable>(from result: AFResult<APIResponse>, for key: String?, type: T.Type) -> Result<T, Error> {
        switch result {
        case .success(let response):
            guard let bodyData = response.bodyData(for: key) else {
                return .failure(MappingError())
            }
            
            do {
                let object = try self.mapToObject(from: bodyData, type: type)
                return .success(object)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
}

//MARK: - Implementation

class JSONMapperImp: JSONMapper {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
        self.decoder.dateDecodingStrategy = .millisecondsSince1970
    }
    
    func mapToObject<T>(from data: Data, type: T.Type) throws -> T where T : Decodable {
        print(JSON(data))
        
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch DecodingError.dataCorrupted(let context) {
            print(context.debugDescription)
        } catch let DecodingError.keyNotFound(key, context) {
            print("\(key.stringValue) was not found, \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(type, context) {
            print("\(type) was expected, \(context.debugDescription) | \(context.codingPath)")
        } catch let DecodingError.valueNotFound(type, context) {
            print("no value was found for \(type), \(context.debugDescription)")
        } catch {
            print("Unknown error")
        }
        
        throw MappingError()
    }
    
}
