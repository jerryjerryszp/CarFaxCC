//
//  ImageCache.swift
//  CarFaxCC
//
//  Created by Jerry Shi on 2020-09-17.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation

import UIKit

class ImageCache {
    /**
     Store the image to cache
    
     - Parameters:
         -  urlString: The image url
         - img: The image to be stored
     */
    static func storeImage(urlString: String, img: UIImage) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        
        let url = URL(fileURLWithPath: path)
        
        let data = img.jpegData(compressionQuality: 0.5)
        try? data?.write(to: url)
        
        var cachedImages = UserDefaults.standard.object(
            forKey: Constants.ListingViewModel.ImageCacheKey
            ) as? [String: String]
        
        if cachedImages == nil {
            cachedImages = [String: String]()
        }
        
        cachedImages?[urlString] = path
        UserDefaults.standard.set(
            cachedImages,
            forKey: Constants.ListingViewModel.ImageCacheKey
        )
    }
    
    /**
     Load the image to the UIImageView
    
     - Parameters:
         -  urlString: The image url
         - completion: The completion handler
     */
    static func loadImage(urlString: String, completion: @escaping (String, UIImage?) -> Void) {
        if let cachedImages = UserDefaults.standard.object(
            forKey: Constants.ListingViewModel.ImageCacheKey
            ) as? [String: String] {
            if let path = cachedImages[urlString] {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    let img = UIImage(data: data)
                    completion(urlString, img)
                    
                    return
                }
            }
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task  = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    storeImage(urlString: urlString, img: image)
                    completion(urlString, image)
                }
            }
        }
        
        task.resume()
    }
}
