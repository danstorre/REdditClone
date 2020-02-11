//
//  ViewerCache.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/23/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import Foundation

typealias Memento = [String: Any]

protocol MementoConvertible {
    var memento: Memento? { get }
    init?(memento: Memento)
}

enum CacheSaver {

    static let keyPostViewCacheList = "keyPostViewCacheList"
    static func setObject(postCacheList: PostViewCacheList) {
        UserDefaults.standard.set(postCacheList.memento, forKey: CacheSaver.keyPostViewCacheList)
    }

    static func restore(saveName: String) -> Any? {
        return UserDefaults.standard.object(forKey: saveName)
    }
}


class PostViewCacheList: MementoConvertible {
    
    private enum Keys {
        static let postCacheArray = "postCacheArray"
    }
    
    required init?(memento: Memento) {
        guard let postCacheArrayMemento = memento[Keys.postCacheArray] as? Data else {
            return nil
        }
        
        let json = JSONDecoder()
        
        if let postCacheArrayMemento = try? json.decode([PostViewItemCache].self, from: postCacheArrayMemento) {
            postCacheArray = postCacheArrayMemento
        }else {
            fatalError("cannot initialize PostViewCacheList")
        }
    }
    
    var postCacheArray: [PostViewItemCache]
    
    init(postCacheArray: [PostViewItemCache]) {
        self.postCacheArray = postCacheArray
    }
    
    var memento: Memento? {
        let jsonEncoder = JSONEncoder()
        guard let postCacheArrayEncoded = try? jsonEncoder.encode(postCacheArray) else {
            return nil
        }
        return [Keys.postCacheArray:  postCacheArrayEncoded]
    }
    
}

struct PostViewItemCache: Codable{
    
    let uuid: String
    let read: Bool
    
    init(uuid: String, read: Bool) {
        self.uuid = uuid
        self.read = read
    }
}

extension PostViewItemCache: Hashable{
    
}
