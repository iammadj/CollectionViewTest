//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainServiceImp().fetchData { result in
            switch result {
            case .success(let items):
                print("Sections count = \(items.count)")
                print("Items count = \(items[0].items.count)")
            case.failure(let error):
                print(error)
            }
        }
    }


}

