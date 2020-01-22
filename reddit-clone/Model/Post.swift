//
//  Post.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import Foundation

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
