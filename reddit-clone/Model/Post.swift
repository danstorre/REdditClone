//
//  Post.swift
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

struct PostView: Readable, Deletable{
    var post: Post
    var isRead: Bool
    var isDeleted: Bool
    
    init(post: Post, isRead: Bool) {
        self.post = post
        self.isRead = isRead
        self.isDeleted = false
    }
}

struct Post: Hashable {
    let title: String
    let entryDate: Date
    let postImageURL: URL
    let comments: Int
    let description: String
    let identifier = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
