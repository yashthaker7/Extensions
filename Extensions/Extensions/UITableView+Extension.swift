//
//  UITableView+Extension.swift
//
//  Created by Yash Thaker on 08/02/19.
//  Copyright © 2019 Yash Thaker. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerReusableCell<T: UITableViewCell>(_: T) {
        let cellId = String(describing: T.self)
        self.register(T.self, forCellReuseIdentifier: cellId)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ indexPath: IndexPath) -> T {
        let cellId = String(describing: T.self)
        return self.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! T
    }
    
    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T) {
        let cellId = String(describing: T.self)
        self.register(T.self, forHeaderFooterViewReuseIdentifier: cellId)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ indexPath: IndexPath) -> T? {
        let cellId = String(describing: T.self)
        return self.dequeueReusableHeaderFooterView(withIdentifier: cellId) as? T
    }
}




