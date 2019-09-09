//
//  UIStoryboard+Extension.swift
//
//  Created by Yash Thaker on 07/02/19.
//  Copyright © 2019 Yash Thaker. All rights reserved.
//

import UIKit

public enum StoryboardName: String {
    case main = "Main"
}

extension UIStoryboard {
    
    class func instantiate<T: UIViewController>(forModule module: StoryboardName = StoryboardName.main) -> T {
        let storyboard = UIStoryboard.init(name: module.rawValue, bundle: nil)
        let name = String(describing: T.self)
        return storyboard.instantiateViewController(withIdentifier: name) as! T
    }
    
}

