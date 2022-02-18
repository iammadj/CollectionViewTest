//
//  Reusable+RegisterCells.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import UIKit

public protocol Reusable {
   
   static var reusableId: String { get }
   
}

extension UICollectionViewCell: Reusable {
    
   public static var reusableId: String { String(describing: self) }
   
}

public extension UICollectionView {
   
   func register<T: UICollectionViewCell>(_ :T.Type) {
      register(T.self, forCellWithReuseIdentifier: T.reusableId)
   }

   func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
      guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableId, for: indexPath) as? T else {
         fatalError("Could not dequeue cell with identifier: \(T.reusableId)")
      }

      return cell
    }
   
}
