//
//  MainHeaderView.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import UIKit
import TinyConstraints

class MainHeaderView: UICollectionReusableView {
    
    //MARK: - Properties
    
    static let id = "MainHeaderView-Reusable-Id"
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        return label
    }()
    
    //MARK: - Init & life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLable)
        titleLable.edgesToSuperview(insets: .vertical(16.0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLable.text = nil
    }
    
    //MARK: - Configure
    
    func configure(title: String) {
        titleLable.text = title
    }
    
}
