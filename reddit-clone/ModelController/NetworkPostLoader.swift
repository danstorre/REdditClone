//
//  NetworkPostLoader.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/23/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import Foundation


struct NetworkPostLoader: PostLoadable {
    
    func loadPosts(closure: @escaping (PostViewList?) -> () ) {
        
        guard let url = URL(string: "https://www.reddit.com/r/all/top.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, urlresponse, error) in
            
            guard error == nil else{
                return
            }
            
            guard let data = data else {
                return
            }
            
            let jsondecoder = JSONDecoder()
            guard let listpost = try? jsondecoder.decode(ListPost.self, from: data) else {
                return
            }
            
            let postViews = listpost.posts.map { (post) -> PostView in
                return PostView(post: post, isRead: false)
            }
            
            closure(PostViewList(posts: postViews))
        }
        
        task.resume()
    }
    
    
}
