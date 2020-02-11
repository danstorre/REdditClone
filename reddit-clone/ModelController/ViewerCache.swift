//
//  ViewerCache.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/23/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import Foundation


class PostViewItemCache {
    
    let uuid: String
    let read: Bool
    
    init(uuid: String, read: Bool) {
        self.uuid = uuid
        self.read = read
    }
}


class ViewerCache: NSObject {
    
    let queue = DispatchQueue(label: "ViewerCache")
    
    func setObject(postCache: PostViewItemCache) throws{
        queue.sync {
            ViewerCache.cache.setObject(postCache, forKey: postCache.uuid.description as NSString)
        }
    }
    
    func retrieveObject(key: String, closure: @escaping (PostViewItemCache?) -> ()){
        queue.sync {
            closure(ViewerCache.cache.object(forKey: key.description as NSString))
        }
    }
    
    static let cache: NSCache<NSString, PostViewItemCache> = {
        let cache = NSCache<NSString, PostViewItemCache>()
        
        cache.name = "ViewerCache"
        
        // Max 60 images in memory.
        cache.countLimit = 10000
        
        // Max 100 MB used.
        cache.totalCostLimit = 100 * 1024 * 1024
        
        return cache
    }()
    
}
