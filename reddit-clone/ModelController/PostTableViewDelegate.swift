//
//  PostTableViewDelegate.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/23/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import UIKit

class PostTableViewDelegate: NSObject, UITableViewDelegate, PostTableViewCellDelegate {
    var posts: PostViewList?
    weak var delegate: PostTableViewCellDelegate?
    
    init(posts: PostViewList, delegate: PostTableViewCellDelegate) {
        self.posts = posts
        self.delegate = delegate
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? PostTableViewCell else {
            fatalError("PostTableViewCell cell not found")
        }
        
        cell.delegate = self
    }
    
    func dismissButtonDidPressed(postudid: UUID?){
        delegate?.dismissButtonDidPressed(postudid: postudid)
    }
}
