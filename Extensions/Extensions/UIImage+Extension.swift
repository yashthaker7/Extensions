//
//  UIImage+Extension.swift
//
//  Created by Yash Thaker on 07/02/19.
//  Copyright © 2019 Yash Thaker. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func image(from layer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.isOpaque, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        
        // Don't proceed unless we have context
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
