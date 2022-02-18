//
//  MainViewModel.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import Foundation

class MainViewModel {
    
    let id: String
    let headerTitle: String
    let items: [MainViewModel.Item]
    
    init(id: String, headerTitle: String, items: [MainViewModel.Item]) {
        self.id = id
        self.headerTitle = headerTitle
        self.items = items
    }
    
    class func map(responseModel: [MainResponseModel]) -> [MainViewModel] {
        responseModel.map { section in
            MainViewModel(
                id: section.id,
                headerTitle: section.header,
                items: section.items.map({ item in
                    MainViewModel.Item(id: item.id, imageURL: item.image.middle, title: item.title)
                })
            )
        }
    }
    
}

//MARK: - MainViewModel's Item

extension MainViewModel {
    
    class Item {
        
        let id: String
        let imageURL: URL?
        let title: String
        var isSelected: Bool
        
        init(id: String, imageURL: URL?, title: String, isSelected: Bool = false) {
            self.id = id
            self.imageURL = imageURL
            self.title = title
            self.isSelected = isSelected
        }
        
    }
    
}
