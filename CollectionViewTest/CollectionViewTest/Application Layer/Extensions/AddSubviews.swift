//
//  AddSubviews.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
}
