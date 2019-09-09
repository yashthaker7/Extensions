//
//  UICollectionView+Extension.swift
//
//  Created by Yash Thaker on 08/02/19.
//  Copyright © 2019 Yash Thaker. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerReusableCell<T: UICollectionViewCell>(_: T) {
        let cellId = String(describing: T.self)
        self.register(T.self, forCellWithReuseIdentifier: cellId)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        let cellId = String(describing: T.self)
        return self.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! T
    }
    
    func registerReusableSupplementaryView<T: UICollectionReusableView>(elementKind: String, _: T) {
        let cellId = String(describing: T.self)
        self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: cellId)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionViewCell>(elementKind: String, indexPath: IndexPath) -> T {
        let cellId = String(describing: T.self)
        return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: cellId, for: indexPath) as! T
    }
    
}
