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
    let author: String
    let entryDate: Date
    let postImageURL: URL?
    let comments: Int
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
        case description
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: PostCodingKeys.self)
        let itemValues = try values.nestedContainer(keyedBy: ItemPostCodingKeys.self, forKey: .data)
        
        title = try itemValues.decode(String.self, forKey: .title)
        author = try itemValues.decode(String.self, forKey: .author)
        let entryDate_utc = try itemValues.decode(Double.self, forKey: .entryDate)
        entryDate = Date(timeIntervalSince1970: entryDate_utc)
        if let postImageURLString = try? itemValues.decode(String.self, forKey: .thumbnail) {
            postImageURL = URL(string: postImageURLString)
        } else {
            postImageURL = nil
        }
        
        comments = try itemValues.decode(Int.self, forKey: .num_comments)
    }
}
