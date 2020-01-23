//
//  PostCollection.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import Foundation

class PostViewList {
    private var posts: [PostView]
    var after: String?
    
    var availablePosts: [PostView] {
        return posts.filter({return !$0.isDeleted})
    }
    
    func appendNew(posts: [PostView]) {
        self.posts.append(contentsOf: posts)
    }
    
    init(posts: [PostView], after: String?) {
        self.posts = posts
        self.after = after
    }
}
