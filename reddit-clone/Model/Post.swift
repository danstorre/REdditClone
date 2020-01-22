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

extension Post: Decodable {
    
    enum PostCodingKeys: String, CodingKey {
        case kind
        case data
    }
    
     enum ItemPostCodingKeys: String, CodingKey {
           case title
           case author
           case thumbnail
           case entryDate = "created_utc"
           case num_comments
    }
    
    init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: PostCodingKeys.self)
           let itemValues = try values.nestedContainer(keyedBy: ItemPostCodingKeys.self, forKey: .data)
        
           title = try itemValues.decode(String.self, forKey: .title)
           entryDate = try itemValues.decode(Date.self, forKey: .title)
           postImageURL = try itemValues.decode(URL.self, forKey: .title)
           comments = try itemValues.decode(Int.self, forKey: .title)
           description = try itemValues.decode(String.self, forKey: .title)
    }
}
