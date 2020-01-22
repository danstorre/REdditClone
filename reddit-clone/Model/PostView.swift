//
//  PostView.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import Foundation

protocol Readable {
    var isRead: Bool { get set }
}

protocol Deletable {
    var isDeleted: Bool {get set}
}

struct PostView: Readable, Deletable, Hashable{
    var post: Post
    var isRead: Bool
    var isDeleted: Bool
    let identifier = UUID()
    
    init(post: Post, isRead: Bool) {
        self.post = post
        self.isRead = isRead
        self.isDeleted = false
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func ==(lhs: PostView, rhs: PostView) -> Bool {
        return lhs.post == rhs.post
    }
}
