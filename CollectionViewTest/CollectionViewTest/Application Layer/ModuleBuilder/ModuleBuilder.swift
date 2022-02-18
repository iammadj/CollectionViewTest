//
//  ModuleBuilder.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import UIKit

protocol ModuleBuilder {
    
    static func buildMainModule() -> UIViewController
    
}

class ModuleBuilderImp: ModuleBuilder {
    
    static func buildMainModule() -> UIViewController {
        let view = MainViewController()
        let presenter: MainViewPresenterProtocol = MainViewPresenter(view: view, viewModel: [])
        view.presenter = presenter
        
        return view
    }
    
}
