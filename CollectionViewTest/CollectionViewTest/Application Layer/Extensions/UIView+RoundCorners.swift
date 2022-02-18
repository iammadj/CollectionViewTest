//
//  UIView+RoundCorners.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import UIKit

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner = .allCorners, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
    
}
