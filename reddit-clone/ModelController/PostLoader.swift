//
//  PostLoader.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import Foundation

protocol PostLoadable {
    func loadPosts(closure: @escaping (ListPost?) -> () )
    func loadNext(after: String, _ :  @escaping (ListPost?) -> () )
}

struct PostFileLoader: PostLoadable {
    func loadNext(after: String, _: @escaping (ListPost?) -> ()) {
        
    }
    
    func loadPosts(closure: @escaping (ListPost?) -> () ) {
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
        
        closure(listpost)
    }
    
    
}
