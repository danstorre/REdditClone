//
//  Post.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import Foundation

struct Post: Hashable {
    let name: String
    let identifier = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    func contains(query: String?) -> Bool {
        guard let query = query else { return true }
        guard !query.isEmpty else { return true }
        let lowerCasedQuery = query.lowercased()
        return name.lowercased().contains(lowerCasedQuery)
    }
}
