//
//  NetworkPostLoader.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/23/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import Foundation


class NetworkPostLoader: NSObject, PostLoadable, API {
    
    var session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func loadNext(after: String,  _ closure: @escaping (PostViewList?) -> ()) {
        executeDataRequestWithCustomSession(
            session: session,
            request: PostRequestFactory.next(after: after).makeRequest())
        { [weak self] (data, response) in
            
            guard let sSelf = self, let data = data else{
                return
            }
            
            sSelf.parse(data: data, closure: closure)
        }
    }
    
    
    func loadPosts(closure: @escaping (PostViewList?) -> () ) {
        
        guard let url = URL(string: "https://www.reddit.com/top.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] (data, urlresponse, error) in
            
            guard error == nil else{
                return
            }
            
            guard let data = data else {
                return
            }
            
            self?.parse(data: data, closure: closure)
        }
        
        task.resume()
    }
    
    func parse(data: Data, closure: @escaping (PostViewList?) -> () ) {
        let jsondecoder = JSONDecoder()
        guard let listpost = try? jsondecoder.decode(ListPost.self, from: data) else {
            return
        }
        
        let postViews = listpost.posts.map { (post) -> PostView in
            return PostView(post: post, isRead: false)
        }
        
        closure(PostViewList(posts: postViews))
    }
    
    
}
