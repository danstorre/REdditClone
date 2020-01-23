//
//  PostLoader.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import Foundation

protocol PostLoadable {
    func loadPosts(closure: @escaping (PostViewList?) -> () )
}

struct PostFileLoader: PostLoadable {
    
    func loadPosts(closure: @escaping (PostViewList?) -> () ) {
        var json = Data()
        if let path = Bundle.main.path(forResource: "topsample", ofType: "json") {
            do {
                json = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch {
                fatalError("error reading topsample.json file")
            }
        }
        let jsondecoder = JSONDecoder()
        guard let listpost = try? jsondecoder.decode(ListPost.self, from: json) else {
            return
        }
        
        let postViews = listpost.posts.map { (post) -> PostView in
            return PostView(post: post, isRead: false)
        }
        
        closure(PostViewList(posts: postViews))
    }
    
    
}
