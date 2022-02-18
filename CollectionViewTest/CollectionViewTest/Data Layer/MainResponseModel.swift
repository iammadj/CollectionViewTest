//
//  MainResponseModel.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import Foundation

struct MainResponseModel: Decodable {
    
    let id: String
    let header: String
    let itemsTotal: Int
    let itemsToShow: Int
    let items: [Item]
    
}

//MARK: - MainResponseModel's Item Model

extension MainResponseModel {
    
    struct Item: Decodable {
        
        let id: String
        let image: Image
        let title: String
        
    }
    
}

//MARK: - Item's Image Model

extension MainResponseModel.Item {
    
    struct Image: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case small = "1x"
            case middle = "2x"
            case big = "3x"
        }
        
        let small: URL?
        let middle: URL?
        let big: URL?
    }
    
}
