//
//  MainViewPresenter.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import Foundation

//MARK: - View Protocol

protocol MainViewProtocol: AnyObject {
    
    func updateView(with items: [MainViewModel])
    
}

//MARK: - Presenter Protocol

protocol MainViewPresenterProtocol: AnyObject {
    
    init(view: MainViewProtocol?, viewModel: [MainViewModel])
    
    func fetchData()
    func setSelectedItem(at indexPath: IndexPath, isSelected: Bool)
}

//MARK: - Presenter Implementation

class MainViewPresenter: MainViewPresenterProtocol {
    
    //MARK: - Properties
    
    private weak var view: MainViewProtocol?
    private var viewModel: [MainViewModel]
    
    private let service: MainService
    
    //MARK: - Init
    
    required init(view: MainViewProtocol?, viewModel: [MainViewModel]) {
        self.view = view
        self.viewModel = viewModel
        self.service = MainServiceImp()
    }
    
    //MARK: - Methods
    
    func fetchData() {
        service.fetchData { [weak self] result in
            switch result {
            case .success(let items):
                let viewModel = MainViewModel.map(responseModel: items)
                self?.viewModel = viewModel
                self?.view?.updateView(with: viewModel)
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func setSelectedItem(at indexPath: IndexPath, isSelected: Bool) {
        viewModel[indexPath.section].items[indexPath.row].isSelected = isSelected
    }
    
}
