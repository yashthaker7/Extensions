//
//  ViewController.swift
//  Extensions
//
//  Created by SOTSYS205 on 08/02/19.
//  Copyright © 2019 SOTSYS205. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgUrl = createUrlInTemp("img.jpeg")
        
        if let img = UIImage.image(from: self.view.layer),
            let imgData = img.jpegData(compressionQuality: 1.0) {
            do {
                try imgData.write(to: imgUrl)
                print(imgUrl)
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }


}

