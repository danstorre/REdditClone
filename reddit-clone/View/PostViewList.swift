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
    var availablePosts: [PostView] {
        return posts.filter({return !$0.isDeleted})
    }
    
    init(posts: [PostView]) {
        self.posts = posts
    }
}
