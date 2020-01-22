//
//  ListPost.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import Foundation

struct ListPost: Decodable {
    
    var posts: [Post]
    
    enum PostCodingKeys: String, CodingKey {
        case kind
        case data
    }
    
    enum NestedLevel1PostCodingKeys: String, CodingKey {
        case children
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: PostCodingKeys.self)
        let firstLevel = try values.nestedContainer(keyedBy: NestedLevel1PostCodingKeys.self, forKey: .data)
        posts = try firstLevel.decode([Post].self, forKey: .children)
    }
}
