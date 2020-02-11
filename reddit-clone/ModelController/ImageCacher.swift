//
//  ImageCacher.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/23/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import UIKit

enum ErrorCache: Error {
    case noImageToCache
}

class ImageCacher {
    
    typealias object = UIImage?
    typealias key = URL
    
    let queue = DispatchQueue(label: "ImageCacher")
    
    func setObject(key: URL, object: UIImage?) throws{
        guard let image = object else {
            throw ErrorCache.noImageToCache
        }
        queue.sync {
            ImageCacher.cache.setObject(image, forKey: key.absoluteString as NSString)
        }
    }
    
    func retrieveObject(key: URL, closure: @escaping (UIImage?) -> ()){
        queue.sync {
            closure(ImageCacher.cache.object(forKey: key.absoluteString as NSString))
        }
    }
    
    static let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        
        cache.name = "ImageCacher"
        
        // Max 60 images in memory.
        cache.countLimit = 60
        
        // Max 30 MB used.
        cache.totalCostLimit = 30 * 1024 * 1024
        
        return cache
    }()
    
}
