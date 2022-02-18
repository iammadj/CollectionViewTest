//
//  MainCollectionViewCell.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import UIKit
import Kingfisher
import TinyConstraints

class MainCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let blurredView = BlurredView()
    
    override var isSelected: Bool {
        didSet { setSelected(isSelected) }
    }
    
    //MARK: - Init & life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        embedSubviews()
        setSubviewsConstraints()
        roundCorners(radius: 16.0)
        contentView.roundCorners(radius: 16.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        blurredView.prepareForReuse()
    }
    
    //MARK: - Configure
    
    func configure(with item: MainViewModel.Item) {
        if let url = item.imageURL {
            imageView.kf.setImage(with: url)
        }
        
        blurredView.configure(title: item.title)
    }
    
    func setSelected(_ isSelected: Bool) {
        contentView.layer.borderWidth = isSelected ? 3.0 : 0.0
        contentView.layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor
    }
    
}

//MARK: - Private Methods

extension MainCollectionViewCell {
    
    private func embedSubviews() {
        contentView.addSubviews(imageView, blurredView)
    }
    
    private func setSubviewsConstraints() {
        imageView.edges(to: contentView)
        
        blurredView.edges(to: contentView, excluding: .top)
        blurredView.top(to: contentView, offset: 32.0, relation: .equalOrGreater)
    }
    
}
