//
//  CachedImageView.swift
//
//  Created by Yash Thaker on 01/01/18.
//  Copyright © 2018 YashThaker. All rights reserved.
//

import UIKit

class CachedImageView: UIImageView {
    
    static let imageCache = NSCache<NSString, UIImage>()
    
    private var urlStringForChecking: String?
    
    func loadImage(urlString: String, completion: (() -> ())? = nil) {
        startLoading()
        
        image = nil
        
        self.urlStringForChecking = urlString
        
        if let cachedItem = CachedImageView.imageCache.object(forKey: urlString as NSString) {
            image = cachedItem
            stopLoading()
            completion?()
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if error != nil {
                DispatchQueue.main.async { self?.stopLoading() }
                return
            }
            
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    CachedImageView.imageCache.setObject(image, forKey: urlString as NSString)
                    
                    if urlString == self?.urlStringForChecking {
                        self?.image = image
                        self?.stopLoading()
                        completion?()
                    }
                } else {
                    self?.stopLoading()
                }
            }
            
        }).resume()
    }
    
    func clearCachedImageFromUrl(_ urlString: String) {
        CachedImageView.imageCache.removeObject(forKey: urlString as NSString)
    }
    
    // loading indicator
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .gray)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.isHidden = true
        return ai
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func startLoading() { activityIndicator.startAnimating() }
    private func stopLoading() { activityIndicator.stopAnimating() }
    
}
