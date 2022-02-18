//
//  MainService.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import Foundation

protocol MainService {
    func fetchData(_ completion: @escaping (Result<[MainResponseModel], Error>) -> Void)
}

//MARK: - Implementation

struct MainServiceImp: MainService {
    
    //MARK: - Properties
    
    private let apiManager: APIManager
    private let jsonMapper: JSONMapper
    
    //MARK: - Init
    
    init(apiManager: APIManager = APIManagerImp(), jsonMapper: JSONMapper = JSONMapperImp()) {
        self.apiManager = apiManager
        self.jsonMapper = jsonMapper
    }
    
    //MARK: - Methods
    
    func fetchData(_ completion: @escaping (Result<[MainResponseModel], Error>) -> Void) {
        apiManager.request(with: MainEndpoint.fetchData) { result in
            let mappedResult = jsonMapper.mapToResult(from: result, for: "sections", type: [MainResponseModel].self)
            completion(mappedResult)
        }
    }
    
}
