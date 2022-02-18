//
//  BlurredView.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import UIKit
import TinyConstraints

class BlurredView: UIView {
    
    //MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var blurEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        return blurEffectView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    func prepareForReuse() {
        titleLabel.text = nil
    }
    
    //MARK: - Private Methods
    
    private func setupLayout() {
        addSubviews(blurEffect, titleLabel)
        
        blurEffect.edgesToSuperview()
        
        titleLabel.edgesToSuperview(insets: .horizontal(16.0) + .vertical(16.0))
    }
    
}
