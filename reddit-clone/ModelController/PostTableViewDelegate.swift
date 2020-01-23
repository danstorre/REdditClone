//
//  PostTableViewDelegate.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/23/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import UIKit

class PostTableViewDelegate: NSObject, UITableViewDelegate {
    var posts: PostViewList?
    
    init(posts: PostViewList) {
        self.posts = posts
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        posts?.availablePosts[indexPath.row].isRead = true
        
        tableView.performBatchUpdates({
            if let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell {
                UIView.animate(withDuration: 0.3) {
                    cell.readIcon.isHidden = true
                }
            }
        }) { (_) in
            
        }
    }
    

}
